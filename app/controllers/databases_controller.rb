require 'date'
require 'sqlite3'
include ActionView::Helpers::NumberHelper
class DatabasesController < ApplicationController
skip_before_filter :verify_authenticity_token
  @@pdf ="k"
  before_filter :authorize
        def index
        params[:q] = {s: 'group asc'}.merge(params[:q] || {})
           if params[:app].present?
             @app = App.find(params[:app])
             params[:q][:app_id_eq] = @app.id
           end 
	  if params[:object]
	        @obj = params[:object]
#	    @pdf = @@pdf
           if params[:list_v]
		@listv = true
	    end
         end

	  if params[:put_data]
              send_data @@pdf.render, filename: "#{params[:put_data]}.pdf", type: "application/pdf",disposition: "attachment"
	  else
    if current_user.admin?
    @q = current_user.organization.databases.search(params[:q])  
    @databases = @q.result
    #@databases = current_user.organization.databases
    else
     @databases = current_user.databases
    end 
   @apps = current_user.organization.apps
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @databases }
    end
end
  end
  

 def options
	  @database =params[:ids]
  render :partial => "options", :layout => false
 end
  def view_report
	 
   @document = current_user.organization.databases.find(params[:put_datas].to_i)
   
   @type = params[:type]
   @fields1 = params[:fields]
   @data = params[:data]
   @not_used = params[:not_used]
  @@pdf = ReportPdf.new(@document,@type,@fields1,@data,@not_used)
  redirect_to databases_url(:object => @document.db_name,:list_v => true)

  end

  
  
  def show
    @database = current_user.organization.databases.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @database }
    end
  end
  def new
    @database = Database.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @database }
    end
  end

  def edit
    @database = current_user.organization.databases.find(params[:id])
  end

 def create
    @app = sanitized_app(params[:database])
    @database = Database.new(params[:database])
    @database.organization = current_user.organization
    @database.user = current_user
    @database.app = @app
    data = Database.class_eval("@@synchronize").call("Mysql",params[:database][:db_connection_string],"create_tables","current_database") if params[:database][:db_technology]== "MySQL" 
  
#************creation od DB's based on technology******************
    respond_to do |format|
      if @database.save
         #render :text => params.inspect and return
	       if  params[:database][:db_technology]== "Sqlite"
              data =  get_sqlite_schema(@database)
             render :text => data and return
	         if  data.class != String && !data.nil? 
			msg = update_sqlite_schema(data,@database)
			 @database.update_attributes(:last_sync => Date.today)
                  format.html { redirect_to @database, notice: 'Database was successfully created.' }
		else
		@database.destroy
                format.html { redirect_to @database, notice: "#{msg}" }

	         end
	       else
	        if data.class != String && !data.nil? &&  params[:database][:db_technology]== "MySQL" 
                  Database.update_tables_in_local_database(@database,data) 
	          @database.update_attributes(:last_sync => Date.today,:oftables => @database.tables.length,:ofrecords => @database.tables.sum('ofrows'),:offields => @database.tables.sum('ofcolumns'))
                  format.html { redirect_to @database, notice: 'Database was successfully created.' }
		else
		@database.destroy
                format.html { redirect_to @database, notice: "#{data}" }
	       end
	    end
      else
        format.html { render action: "new" }
        format.json { render json: @database.errors, status: :unprocessable_entity }

      end
    end
  end

  def update
    @app = sanitized_app(params[:database])
    @database = current_user.organization.databases.find(params[:id])
    @database.app = @app
=begin
  if @database
       if !(@database.db_connection_string === params[:database][:db_connection_string] )
	  render :text =>  "kj" and return
       end
  end
=end
    respond_to do |format|
      if @database.update_attributes(params[:database])
        
        format.html { redirect_to @database, notice: 'Database was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @database = Database.find(params[:id])
    @database.destroy

    respond_to do |format|
      format.html { redirect_to databases_url }
      format.json { head :no_content }
    end
  end

def search

    @q = current_user.organization.databases.search(params[:q])
    if params[:q]
      @databases = @q.result#result(:distinct  => true).find(:all,:order=>"updated_at DESC")
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end


  def database_schema1 #**************synchrnizing database schema***********
     current_database = current_user.organization.databases.find(params[:id])
    data = Database.class_eval("@@synchronize").call("Mysql",current_database.db_connection_string,"update_tables",current_database) if current_database.db_technology == "MySQL" 
    current_database.update_attributes(:last_sync => Date.today)
    #DateTime.now.strftime('%m/%d/%Y')
    if data == "success"
    current_database.update_attributes(:oftables => current_database.tables.length,:ofrecords => current_database.tables.sum('ofrows'),:offields => current_database.tables.sum('ofcolumns'))

    redirect_to databases_url, notice: 'Database was successfully synchronized' 
    else
    redirect_to databases_url, notice: 'Databse was not successfully synchronized'
    end
    
  end

   def database_schema
   @database = current_user.organization.databases.find(params[:id])
=begin
        @conn_str = current_user.organization.databases.find(params[:id])
        @conn_str = @conn_str.db_connection_string
	if @conn_str
        @h_type = get_schema(@conn_str)
        @error = @h_type if @h_type.class == String
       ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/DBMap_development")
        else
          return "connection string error"
       ActiveRecord::Base.establish_connection("mysql2://root:root@localhost/DBMap_development")
        end 
=end
 end
def block_tree_view 

 	respond_to do |format|
		if request.form_data? 
                       @conn_str = current_user.organization.databases.find(params[:id])
	               @show_active =params[:active];@type = params[:theme]
		       p "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
		       p params[:theme]
		       @database = @conn_str
		       p params[:active]
	 		format.js{@database}
		else
                       @conn_str = current_user.organization.databases.find(params[:id])
         		format.html
	 		format.js{@result = "show_active"}
		end
	end

end
 def get_schema(conn_str) #************getting schema*****************
        @conn_str = conn_str 
 	begin
		ActiveRecord::Base.establish_connection(@conn_str)
		h1 =Hash.new
		ActiveRecord::Base.connection.tables.each do |table_name|
			h1[table_name] = ActiveRecord::Base.connection.columns(table_name).map {|c| 
			  h2 = Hash[:name => c.name,:type => c.type.to_s,:limit => c.limit.to_s]
			}
			h1[table_name] << Hash[:count => ActiveRecord::Base.connection.execute("SELECT count(*) count FROM  #{table_name}  ").first,:database => ActiveRecord::Base.connection_config[:database]]
		end
		
		return h1
		rescue Exception => e
	     error_message= "#{e.message}"
	      return "connnection is not established verify host address" if error_message.match("113")
     	  return "connection is not established verify credentials" if error_message.match("111")
          # return "Database not exist in the server "
          #return "Cannot connect with the database"   
         return e.message
 	end
end


def get_sqlite_schema(conn_str)
begin
if !File.exist?("public/sql_dumps/#{conn_str.db_file.file.filename}")
  system "sqlite3 'public#{conn_str.db_file}' .dump | sqlite3 'public/sql_dumps/#{conn_str.db_file.file.filename}'"

end

  	ActiveRecord::Base.connection.close

		
 conn = SQLite3::Database.open("public/sql_dumps/#{conn_str.db_file.file.filename}")
		 conn.results_as_hash = true
   a = conn.execute("SELECT name FROM sqlite_master WHERE type='table'")
   h1 = Hash.new
   a.each do |c|
	    h1[c["name"]] = 1
   end
   
  h1.keys.each do|x|

   stmt = conn.prepare( "select * from '#{x}'" ) 
   h2 = Hash.new()

   h2[:ofcolumns] = stmt.column_count
   h2[:column_types] = stmt.types
     a = Array.new
   h2[:column_types].each do |x|
     a.push(x.delete("a-zA-Z()")) if !x.nil?
     x = x.gsub!(/\(.*\)/, "")  if !x.nil?
   end
   h2[:columns] = stmt.columns
   h2[:sizes] = a
    record = conn.execute("SELECT Count(*) as records FROM '#{x}'")

    h2[:records] = record[0]["records"] if record.any? 
	    h1[x] = h2
   end
return  h1



rescue Exception => e
	return e.message
end

end


def update_sqlite_schema(data,conn_str)
	data.each do |k,v|
		table = conn_str.tables.create(:table_name => k,:ofrows => v[:records],:ofcolumns => v[:ofcolumns],:organization_id => conn_str.organization_id,:user_id =>conn_str.user_id)
		v[:columns].each do |x|

		table.fields.create(:field_name => x,:field_size => v[:sizes][v[:columns].index(x)],:field_type =>v[:column_types][v[:columns].index(x)],:organization_id => conn_str.organization_id,:user_id =>conn_str.user_id)
		end
	end
	return "success"
end
  def dataview
	  #conn = Database.find(params[:id]).db_connection_string
	  #@data = Database.new.dataview(conn)
  	@database  = current_user.organization.databases.find(params[:id])
  end
 def db_data_view
    if current_user.admin?
    @q = current_user.organization.databases.search(params[:q])  
    @databases = @q.result
    #@databases = current_user.organization.databases
    else
     @databases = current_user.databases
    end 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @databases }
    end
 end
 def db_search_view
    @db_list = current_user.organization.databases
    @q = current_user.organization.databases.search(params[:q])
    @databases = @q.result(:distinct => true)

 end 

 def db_search

    @db_list = current_user.organization.databases
    @q = current_user.organization.databases.search(params[:q])
   if params[:q]
   if params[:q][:tables_database_name_cont]!="" and params[:q][:tables_table_name_cont] ==""

   @db = current_user.organization.databases.where(:id => params[:db_id].to_i).first
    @databases = Field.where('field_name = ? AND database_name =?', params[:q][:tables_database_name_cont],@db.db_name)
   else
   @db = current_user.organization.databases.where(:id => params[:db_id].to_i).first
   @databases = Table.where('table_name = ? AND database_name =?',params[:q][:tables_table_name_cont],@db.db_name)
   end 
   end 
   
 end
private

  def sanitized_app(params)
    #sanitize app_id
    app_id = params.delete(:app_id)
    if app_id.present?
      @app = current_user.organization.apps.find(app_id)
    end
  end



end


