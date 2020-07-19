class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.text :title,               null: false, default: ""
      t.string :body,              null: false, default: ""
      t.integer :user_id,          null: false, default: ""
      t.timestamps
    end
  end
end
