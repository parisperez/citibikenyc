class AddAgainColumnCounterpriceToComments < ActiveRecord::Migration
  def change
    add_column :comments, :counterprice, :decimal, :precision => 8, :scale => 2
  end
end
