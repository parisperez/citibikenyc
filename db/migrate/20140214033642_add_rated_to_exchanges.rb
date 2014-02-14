class AddRatedToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :rated, :string
  end
end
