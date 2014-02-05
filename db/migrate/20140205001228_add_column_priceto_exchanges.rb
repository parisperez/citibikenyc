class AddColumnPricetoExchanges < ActiveRecord::Migration
  def change
    change_table :exchanges do |t|
      t.integer :price
    end
  end
end
