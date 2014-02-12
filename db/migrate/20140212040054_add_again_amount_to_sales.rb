class AddAgainAmountToSales < ActiveRecord::Migration
  def change
    add_column :sales, :amount, :decimal, :precision => 8, :scale => 2
  end
end
