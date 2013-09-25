class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.integer :table_id
      t.integer :record_id

      t.timestamps
    end
  end
end
