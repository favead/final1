class ChangeColumnLike < ActiveRecord::Migration[6.1]
  def change
      remove_column :likes, :liked, :boolean
      add_column :likes, :liked, :boolean, default: true
  end
end
