class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :knowledge_id
      t.string :content
      t.float :rate, null: false, default: 0

      t.timestamps
    end
  end
end
