class CreateKeywords < ActiveRecord::Migration[8.0]
  def change
    create_table :keywords do |t|
      t.string :name, null: false
      t.string :category, null: false, default: "기타"
      t.timestamps
    end
    add_index :keywords, :name, unique: true
  end
end
