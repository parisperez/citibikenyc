class DeleteColumnCounterpriceToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :counterprice, :integer
  end
end
