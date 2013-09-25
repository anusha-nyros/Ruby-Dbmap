

require 'rubygems'
require 'mysql2'
require 'dbi'
require "active_record"
require "net-ssh"

# Mysql2::Client.new(:host => "10.90.90.121", :username => "root", :password => "root", :port => 3306, :database => "honeys", :socket => nil, :flags => 2)
# begin
     # # connect to the MySQL server
      # # dbh =DBI.connect("DBI:Mysql:ozzkey_development:localhost","root", "root")
#      
     # # dbh = DBI.connect( "DBI:Mysql:database=ozzkeyfeb1;server=10.90.90.121;port=3306", "root","root")
     # # dbh = DBI.connect('dbi:Mysql:10.90.90.121', 'root', 'root')
     # # dbh =DBI::connect('DBI', 'dbi:mysql:ozzkeyfeb1@10.90.90.121:3306', 'root', 'root') 
#     
    # dbh = DBI::connect("dbi:Mysql:host=10.90.90.121;sid=mysql", "root", "root");
    # a= dbh.do( "select * from websites;" )
     # puts "Feed list done"
     # dbh.commit
# rescue DBI::DatabaseError => e
     # puts "An error occurred"
     # puts "Error code:    #{e.message}"
     # puts "Error message: #{e.errstr}"
# ensure
     # # disconnect from server
     # dbh.disconnect if dbh
# end
# ActiveRecord::Base.establish_connection(
  # :adapter  => "mysql2",
  # :host     => "10.90.90.121",
  # :port =>3306,
#   
  # :reconnect => false,
  # :username => "root",
  # :password => "root",
  # :database => "honeys"
# )
# a= ActiveRecord::Base.connection.tables
# gateway = Net::SSH::Gateway.new("10.90.90.121", "ranjit", :password => "12345678")
# port = gateway.open("0.0.0.0",3306,3307)
# dbh =DBI.connect("DBI:Mysql:ozzkey_development:10.90.90.121","root", "root")
# @DB = Sequel.connect("#{database}://#{un_encrypt_user}:#{un_encrypt_password}@#{host}/#{database_name}")