class CreateInquiries < ActiveRecord::Migration[8.0]
  def change
    create_table :inquiries do |t|
      t.integer :user_id, null: false
      t.integer :product_id
      t.string :title, null: false
      t.text :content, null: false
      t.string :category
      t.integer :status, default: 0
      t.boolean :is_private, default: false
      t.timestamps
    end
    add_foreign_key :inquiries, :users
    add_foreign_key :inquiries, :products
  end
end
