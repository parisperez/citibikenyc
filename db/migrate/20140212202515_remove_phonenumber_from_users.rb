class RemovePhonenumberFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :phone_number, :string
  end
end
