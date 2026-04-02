class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.integer :inquiry_id, null: false
      t.integer :user_id, null: false
      t.text :content, null: false
      t.timestamps
    end
    add_foreign_key :answers, :inquiries
    add_foreign_key :answers, :users
  end
end
