class CreateKnowledges < ActiveRecord::Migration[6.1]
  def change
    create_table :knowledges do |t|
      t.integer :user_id
      t.integer :category_id
      t.text :title
      t.text :content
      t.integer :classification

      t.timestamps
    end
  end
end
