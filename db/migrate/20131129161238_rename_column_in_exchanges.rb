class RenameColumnInExchanges < ActiveRecord::Migration
  def change
    change_table :exchanges do |t|
      t.rename :user_id, :requester_id
    end
  end
end
