class RenameColumnProductIdInSales < ActiveRecord::Migration
  def change
    change_table :sales do |t|
      t.rename :product_id, :exchange_id
    end
  end
end
