class AddRateColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :rate, :integer
  end
end
