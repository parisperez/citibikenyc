class AddCustomerIdToSales < ActiveRecord::Migration
  def change
    add_column :sales, :customer_id, :string
  end
end
