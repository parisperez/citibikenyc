class AddAgainPriceToExchanges < ActiveRecord::Migration
  def change
      add_column :exchanges, :price, :decimal, :precision => 8, :scale => 2
  end
end
