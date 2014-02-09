class AddColumnCounterpriceToComments < ActiveRecord::Migration
  def change
    add_column :comments, :counterprice, :integer 
  end
end
