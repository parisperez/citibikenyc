class AddColumnStationToExchanges < ActiveRecord::Migration
  def change
      change_table :exchanges do |t|
      t.string :station
    end
  end
end
