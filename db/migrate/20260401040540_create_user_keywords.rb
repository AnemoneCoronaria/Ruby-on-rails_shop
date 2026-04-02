class CreateUserKeywords < ActiveRecord::Migration[8.0]
  def change
    create_table :user_keywords do |t|
      t.integer :user_id, null: false
      t.integer :keyword_id, null: false
      t.timestamps
    end
    add_index :user_keywords, [ :user_id, :keyword_id ], unique: true
  end
end
