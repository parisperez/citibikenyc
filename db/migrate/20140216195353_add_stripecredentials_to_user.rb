class AddStripecredentialsToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :stripe_publishable_key, :string
  end
end
