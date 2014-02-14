class AddRatedbyvendorToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :rated_by_vendor, :string
  end
end
