class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.text :tags
      t.text :content
      t.boolean :published
      t.belongs_to :user

      t.timestamps
    end
  end
end
