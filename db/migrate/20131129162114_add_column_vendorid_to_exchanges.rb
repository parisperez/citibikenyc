class AddColumnVendoridToExchanges < ActiveRecord::Migration
  def change
    change_table :exchanges do |t|
      t.integer :vendor_id
    end
  end
end
