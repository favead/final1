class ChangeRatePosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :rate, :integer, default: 0
  end
end
