class CreateRates < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.integer :count
      t.belongs_to :user
      t.belongs_to :post

      t.timestamps
    end
  end
end
