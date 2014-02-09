class DeletePriceFromExchanges < ActiveRecord::Migration
  def change
        remove_column :exchanges, :price, :integer
  end
end
