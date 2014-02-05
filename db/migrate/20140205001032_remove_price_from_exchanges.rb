class RemovePriceFromExchanges < ActiveRecord::Migration
  def change
    remove_column :exchanges, :price, :decimal
  end
end
