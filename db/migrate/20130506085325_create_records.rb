class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.text :record

      t.timestamps
    end
  end
end
