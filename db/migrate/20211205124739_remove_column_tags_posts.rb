class RemoveColumnTagsPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :tags, :text
  end
end
