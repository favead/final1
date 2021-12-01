class ChangeLikeColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :likes, :count, :integer
    add_column :likes, :liked, :boolean
  end
end
