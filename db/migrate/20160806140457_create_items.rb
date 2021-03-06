class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.float :price
      t.string :name
      t.boolean :real
      t.text :description
      t.float :weight
      t.integer :votes_count
      t.timestamps
    end
    add_index :items, :price
    add_index :items, :name
  end
end
