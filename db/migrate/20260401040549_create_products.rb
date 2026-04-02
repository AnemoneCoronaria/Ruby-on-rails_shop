class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.integer :seller_id, null: false
      t.string :name, null: false
      t.text :description
      t.decimal :price, null: false, precision: 10, scale: 2
      t.integer :stock, null: false, default: 0
      t.integer :discount_rate, default: 0
      t.integer :view_count, default: 0
      t.timestamps
    end
    add_foreign_key :products, :users, column: :seller_id
  end
end
