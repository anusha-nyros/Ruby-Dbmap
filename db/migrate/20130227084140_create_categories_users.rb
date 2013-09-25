class CreateCategoriesUsers < ActiveRecord::Migration
  def self.up  
    create_table :categories_users, :force => true do |t|
      t.integer :category_id
      t.integer :user_id
    end
    add_index :categories_users, :category_id
    add_index :categories_users, :user_id
  end

  def self.down
    drop_table :categories_users
    remove_index :categories_users, :user_id
    remove_index :categories_users, :category_id
  end
end
