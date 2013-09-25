class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.text :message
      t.string :companyname

      t.timestamps
    end
  end
 
  def self.down
     drop_table :pages
  end
end
