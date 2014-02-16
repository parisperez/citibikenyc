class AddStripeaccesskeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_access_key, :string
  end
end
