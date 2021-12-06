class ChangeRatesCountColumg < ActiveRecord::Migration[6.1]
  def change
    rename_column :rates, :count, :mark
  end
end
