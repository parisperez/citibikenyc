class AddColumnStriperecipientidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_recipient_id, :integer
  end
end
