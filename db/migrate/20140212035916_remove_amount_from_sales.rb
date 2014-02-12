class RemoveAmountFromSales < ActiveRecord::Migration
  def change
    remove_column :sales, :amount, :integer
  end
end
