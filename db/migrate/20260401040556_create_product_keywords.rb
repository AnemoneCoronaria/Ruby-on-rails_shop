class CreateProductKeywords < ActiveRecord::Migration[8.0]
  def change
    create_table :product_keywords do |t|
      t.integer :product_id, null: false
      t.integer :keyword_id, null: false
      t.timestamps
    end
    add_index :product_keywords, [ :product_id, :keyword_id ], unique: true
  end
end
