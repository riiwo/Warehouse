class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :img
      t.integer :price
      t.timestamps null: false
    end
  end
end
