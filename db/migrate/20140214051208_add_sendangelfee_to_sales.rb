class AddSendangelfeeToSales < ActiveRecord::Migration
  def change
    add_column :sales, :sendangel_fee, :integer
  end
end
