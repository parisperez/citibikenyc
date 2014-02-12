class RemoveAgainAmountFromSales < ActiveRecord::Migration
  def change
    remove_column :sales, :amount, :decimal, :precision => 8, :scale => 2
  end
end
