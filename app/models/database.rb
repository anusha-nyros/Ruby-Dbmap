class Database < ActiveRecord::Base
  attr_accessible :db_name,:db_environment,:db_hosting,:db_technology,:db_usage,:db_active,:db_connection_string,:db_version,:db_file,:last_sync,:oftables,:ofrecords,:offields,:short_description,:image_name, :crop_x, :crop_y, :crop_w, :crop_h,:app_id
 attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  validates_presence_of :db_technology , :db_name
  validates :short_description,:length => {:maximum =>60}
  belongs_to :user
  belongs_to :organization
  belongs_to :app
mount_uploader :image_name,ImageNameUploader #for multiple attachments
  mount_uploader :db_file,DbFileUploader #for multiple attachments
  has_many :fields, :as => :fieldable,:dependent => :destroy
  has_many :tables,dependent: :destroy
 after_update :crop_image
  Struct.new("SampleData",:table_name,:columns,:records,:next)
  def crop_image
    image_name.recreate_versions! if crop_x.present?
  end
  @@synchronize =  lambda { |type,conn_str,action,database| db = Database.new;
	  return db.clone_sql_database(conn_str) if type == "Mysql" && action == "clone_database"
	  return db.create_sql_tables(conn_str) if type == "Mysql" && action == "create_tables"
	  return db.update_sql_tables(conn_str,database) if type == "Mysql" && action == "update_tables"
  }
  


 def self.get_sql_schema(conn_str)
   @conn_str = conn_str
   begin
    ActiveRecord::Base.establish_connection(@conn_str)
    h1 =Hash.new
    ActiveRecord::Base.connection.tables.each do |table_name|
	h1[table_name] = ActiveRecord::Base.connection.columns(table_name).map {|c| 
         h2 = Hash[:name => c.name,:type => c.type.to_s,:limit => c.limit.to_s]
	}
        h1[table_name] << Hash[:count => ActiveRecord::Base.connection.execute("SELECT count(*) count FROM  #{table_name}  ").first]
   end
   return h1
   rescue Exception => e
      error_message= "#{e.message}"
      return "connnection is not established verify host address" if error_message.match("113")
      return "connection is not established verify credentials" if error_message.match("111")
      return error_message
   ensure
   ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/dbmapapr04")
   end
  end     



 

 def is_same_structure(old_structure,new_structure)
  if old_structure === new_structure then return true else return false end
 end

 def get_structure_difference(conn_str,current_database)
    ActiveRecord::Base.establish_connection(conn_str)
    h1 = get_columns_data
   ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/#{current_database}")
    h2 = get_columns_data
    remove_non_existing_tables(h2.keys - h1.keys)
    addable_difference =Hash.new;i =0;removable_difference =Hash.new;
    HashDiff.diff(h1,h2).each do |x|
       i = i+1
       addable_difference.has_key?( x[1].gsub(/\[.*\]/, "")) ? addable_difference[x[1].gsub(/\[.*\]/, "")]["column#{i}"]= x[2] : addable_difference[x[1].gsub(/\[.*\]/, "")] ={"column#{i}"=> x[2]}  if x[0] == "-"
       removable_difference.has_key?( x[1].gsub(/\[.*\]/, "")) ? removable_difference[x[1].gsub(/\[.*\]/, "")]["column#{i}"]= x[2] : removable_difference[x[1].gsub(/\[.*\]/, "")] ={"column#{i}"=> x[2]}  if x[0] == "+"
    end
   remove_non_existing_columns(removable_difference)
    return addable_difference
  end

  def get_data_difference(all_remote_tables,all_local_tables,define_class)
   addable_difference =Hash.new;i =0;removable_difference =Hash.new;
    HashDiff.diff(all_remote_tables,all_local_tables).each do |x|
       i = i+1
       addable_difference.has_key?( x[1].gsub(/\[.*\]/, "")) ? addable_difference[x[1].gsub(/\[.*\]/, "")]["column#{i}"]= x[2] : addable_difference[x[1].gsub(/\[.*\]/, "")] ={"column#{i}"=> x[2]}  if x[0] == "-"
       removable_difference.has_key?( x[1].gsub(/\[.*\]/, "")) ? removable_difference[x[1].gsub(/\[.*\]/, "")]["column#{i}"]= x[2] : removable_difference[x[1].gsub(/\[.*\]/, "")] ={"column#{i}"=> x[2]}  if x[0] == "+"
    end
    remove_non_existing_records(addable_difference,define_class)
    return removable_difference
  
  end

  def remove_non_existing_tables(tables)
  	tables.each{|table|  ActiveRecord::Base.connection.drop_table(table)}
  end

  def remove_non_existing_columns(difference)
   difference.each do |key,value|
 	      value.values.each do|x|
	      ActiveRecord::Base.connection.remove_column(key,x[:name])
	      end
	 end
  end
 
  def get_columns_data
   h1 = Hash.new
   ActiveRecord::Base.connection.tables.each do |table_name|
     h1[table_name] = ActiveRecord::Base.connection.columns(table_name).map {|c| 
       h2 = Hash[:name => c.name,:type => c.type,:limit => c.limit,:default => c.default]
     }
   end
  return h1
 end

 def create_non_existing_tables(tables)
   tables.each{|x| ActiveRecord::Base.connection.create_table(x) if !ActiveRecord::Base.connection.table_exists?(x)}
 end

 def create_non_existing_columns(difference)
	 difference.each do |key,value|
 	      value.values.each do|x|
	      name = x[:name];type = x[:type];x.delete(:name);x.delete(:type);x[:limit] = x[:limit].to_i
	      ActiveRecord::Base.connection.add_column(key,name,type,x)
	      end
	 end
 end

 def set_structure_difference(difference)
  create_non_existing_tables(difference.keys)
  create_non_existing_columns(difference)
 end
 

 def structure_clone(database_structure)
  subs =database_structure.gsub("\n"," ").split(";")
  subs[0..subs.length-2].each do |x|
   ActiveRecord::Base.connection.execute(x)
  end
 end

 def entire_data
  h1 =Hash.new
  ActiveRecord::Base.connection.tables.each do |table_name|
   h1[table_name] =   ActiveRecord::Base.connection.select_all("select * from #{table_name}")
  end
  #p h1
 return h1
 end

  def data_clone(all_tables,define_class)
   all_tables.each do |key,value|
    key_class = define_class.call(key)
    value.each{|x| x.has_key?("id") && !x["id"].nil? && x["id"].class == Fixnum ?  key_class.new(x){|record| record.id = x["id"];record.created_at = 0 if x.has_key?("created_at")&& x["created_at"].nil?;record.updated_at = 0 if x.has_key?("updated_at")&& x["updated_at"].nil?;record.save} : key_class.create(x) }
   end
 end
   def remove_non_existing_records(difference,define_class)

 difference.each do |key,value|
    key_class = define_class.call(key)
 	      value.values.each do|x|
		      x =x.inject({}){ |h, (n,v)| h[n.to_sym] = v; h }		      
	             r = key_class.where(x)
	             r[0].destroy
	      end
	 end

  end

 def set_data_difference(difference,define_class)
 difference.each do |key,value|

    key_class = define_class.call(key)
    value.values.each do|x|
    x.has_key?("id") && !x["id"].nil? && x["id"].class == Fixnum ?  key_class.new(x){|record| record.id = x["id"];record.created_at = 0 if x.has_key?("created_at")&& x["created_at"].nil?;record.updated_at = 0 if x.has_key?("updated_at")&& x["updated_at"].nil?;record.save} : key_class.create(x) 	     
      end
 end
 end

def clone_sql_database(conn_str)
   @conn_str = conn_str
   begin
   ActiveRecord::Base.establish_connection(@conn_str)

   define_class = Proc.new do |key|
   ActiveRecord::Base.pluralize_table_names = false
   class_name = Object.const_set(key.camelize, Class.new(ActiveRecord::Base))
   end

   current_database = ActiveRecord::Base.connection.current_database
   database_structure1 = ActiveRecord::Base.connection.structure_dump
   all_remote_tables = entire_data
   ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/dbmapapr04")
 ActiveRecord::Base.connection.execute("CREATE DATABASE IF NOT EXISTS #{current_database}")
  ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/#{current_database}")
   database_structure2 = ActiveRecord::Base.connection.structure_dump
   if !database_structure2.blank?
     if !is_same_structure(database_structure1,database_structure2)
      difference =  get_structure_difference(conn_str,current_database)
      set_structure_difference(difference) if difference.any?
     end
  else
    structure_clone( database_structure1)
  end 
   all_local_tables = entire_data
   data_clone(all_remote_tables,define_class) if  !all_local_tables.values.reject{ |c| c.empty? }.any?
   if all_local_tables.values.reject{ |c| c.empty? }.any?
      difference = get_data_difference(all_local_tables,all_remote_tables,define_class)
      set_data_difference(difference,define_class) if difference.any?
   end
#select 5 records in sql;

   return "success"

   rescue Exception => e
     error_message= "#{e.message}"
     return "connnection is not established verify host address" if error_message.match("113")

     return "connection is not established verify credentials" if error_message.match("111")
     p error_message
   ensure
   ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/dbmapapr04")
   end
end


def self.update_tables_in_local_database(database,data)
   data[0].each do |k,v|
   k = database.tables.create(:table_name => k,:database =>database,:database_name => database.db_name,:organization_id => database.organization_id,:user_id => database.user_id)

   v.each do |l,m|
	    k.update_attributes(l => m)
   end
   end
   data[1].each do|t,f_hash|
     table = database.tables.find_by_table_name(t)
     if table
	     f_hash.each do|x|
      f  = table.fields.create(x)
    f.update_attributes(:database => database,:user_id => table.user_id,:organization_id => table.organization_id,:database_name => database.db_name,:table_name =>table.table_name)

	     end

     end
   end
      # insert_sample_records(data[2],database)

end
def get_data_to_update
    data = Array.new();	h1 = Hash.new();h2= Hash.new();home = last ="a"
    ActiveRecord::Base.connection.tables.each do |table_name|
	h1[table_name] = Hash[:ofcolumns => ActiveRecord::Base.connection.columns(table_name).length,:ofrows => ActiveRecord::Base.connection.execute("SELECT count(*) count FROM  #{table_name} ").first[0]]

	h2[table_name] = ActiveRecord::Base.connection.columns(table_name).map {|c| 
         h3 = Hash[:field_name => c.name,:field_type => c.type.to_s,:field_size => c.limit.to_s]
	}

   end
#   Struct.new("SampleData",:table_name,:columns,:records,:next)
     ActiveRecord::Base.connection.tables.each_with_index do |table_name, i|
	    if i == 0
		   home = last = get_five_records(table_name);
	    else
	           new_node = get_five_records(table_name)
		   last.next = new_node
		   last =last.next;
	    end
    end


    data[0] = h1;data[1]= h2;data[2] = home
    return data
end

def create_sql_tables(conn_str)
   begin
    reconnected_database = ActiveRecord::Base.connection.current_database
    ActiveRecord::Base.establish_connection(conn_str)
return get_data_to_update
    rescue Exception => e
     error_message= "#{e.message}"
     return "connnection is not established verify host address" if error_message.match("113")
     return "connection is not established verify credentials" if error_message.match("111")
     return error_message
   ensure
   ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/#{reconnected_database}")
   end

end

def get_addable_removable_column_differences(difference)
	 addable_difference =Hash.new;i =0;removable_difference =Hash.new;diff = Hash.new
    difference.each do |x|
       i = i+1
       addable_difference.has_key?( x[1].gsub(/\[.*\]/, "")) ? addable_difference[x[1].gsub(/\[.*\]/, "")]["column#{i}"]= x[2] : addable_difference[x[1].gsub(/\[.*\]/, "")] ={"column#{i}"=> x[2]}  if x[0] == "-"
       removable_difference.has_key?( x[1].gsub(/\[.*\]/, "")) ? removable_difference[x[1].gsub(/\[.*\]/, "")]["column#{i}"]= x[2] : removable_difference[x[1].gsub(/\[.*\]/, "")] ={"column#{i}"=> x[2]}  if x[0] == "+"
    end
    diff[:removable_difference]= removable_difference;
diff[:addable_differnce] = addable_difference;    
return diff

end
def get_addable_removable_table_differences(database_1,database_2)
 h1  =  Hash.new
h1[:removable_tables] = database_2 - database_1
h1[:addable_tables] = database_1 - database_2
return h1
end
def set_addable_removable_table_differences(difference,database)
	difference.each do |type,differences|
	   if type == :addable_tables
		 differences.each{|x| table = database.tables.create(:table_name => x);table.update_attributes(:organization_id => database.organization_id,:user_id => database.user_id,:database_name => database.db_name)}
	   elsif type == :removable_tables
		  differences.each{|x| table = database.tables.find_by_table_name(x); table.destroy if table;}
           end
	end
end
def set_addable_removable_column_differences(difference,database)
 difference.each do |type,differences|
     if type == :removable_difference
         differences.each do |table,columns|
	    changable_table = database.tables.find_by_table_name(table)
	    columns.each do |x| 
		   field = changable_table.fields.where(x[1]).first if changable_table
		   field.destroy if !field.nil?
	    end
	 end
     elsif type == :addable_differnce
	   differences.each do |table,columns|
	     changable_table = database.tables.find_by_table_name(table)
	     columns.each{ |x| table = changable_table.fields.create(x[1]) if changable_table;table.update_attributes(:organization_id => database.organization_id,:user_id => database.user_id,:database_name => database.db_name,:table_name =>changable_table.table_name) if table;} 	   
	   end
     end
 end
end
def set_numnber_of_rows_and_columns(data,database)
 data.each do |k,v|
    table = database.tables.find_by_table_name(k)
     if table
  	    table.update_attributes(v)
   end
   end

end
def insert_sample_records(node,database)
 while node != "nil"
    table = Table.find_by_table_name_and_database_name(node.table_name,database.db_name)
    if table
    table.update_attributes(column_type:node.columns.to_s.delete('[]/"'))
    table.records.clear
    node.records.each do |x|
	   #record = Record.find_or_create_by_record(node.columns.to_s.delete('[]/"'))
	    table.records << Record.new(record:x.to_s.delete('[]/"'))
    end
    end
    node = node.next
 end
end
def update_sql_tables(conn_str,database)
  begin
    reconnected_database = ActiveRecord::Base.connection.current_database
     h2= Hash.new()
     database.tables.each do |table_name|
	h2[table_name.table_name] = table_name.fields.map {|c| 
         h3 = Hash[:field_name => c.field_name,:field_type => c.field_type.to_s,:field_size => c.field_size.to_s]
	}
      end
      ActiveRecord::Base.establish_connection(conn_str)
      data = get_data_to_update
       column_diff = get_addable_removable_column_differences( HashDiff.diff(data[1],h2))
       table_diff = get_addable_removable_table_differences(data[1].keys,h2.keys)
       ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/#{reconnected_database}")
       set_addable_removable_table_differences(table_diff,database)
       set_addable_removable_column_differences(column_diff,database)
       set_numnber_of_rows_and_columns(data[0],database)
       insert_sample_records(data[2],database)
       return "success"
          ensure
   ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/#{reconnected_database}")

    end

end
def dataview(conn_str)
  begin
   reconnected_database = ActiveRecord::Base.connection.current_database
   Struct.new("SampleData",:table_name,:columns,:records,:next)
   ActiveRecord::Base.establish_connection(conn_str)
   home = last = "a"
    ActiveRecord::Base.connection.tables.each_with_index do |table_name, i|
	    if i == 0
		   home = last = get_five_records(table_name);
	    else
	           new_node = get_five_records(table_name)
		   last.next = new_node
		   last =last.next;
	    end
    end
    return(home)
    ensure
   ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/#{reconnected_database}")
  end
end
def get_five_records(table_name)
 data = Struct::SampleData.new()
		    data.table_name = table_name;
                    dat = ActiveRecord::Base.connection.exec_query("select * from #{table_name} Limit 5")
		    data.columns = dat.columns
		    data.records = dat.rows
		    data.next = "nil"
		    return data
end

def print_data(home)
	node = home
while node.next != "nil"
p node.columns.first.to_s.delete('[]/"')
node = node.next
end
end
end
