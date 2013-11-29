class CreateExchanges < ActiveRecord::Migration
 def change
    create_table :exchanges do |t|
    t.boolean :is_bike
    t.date :date
    t.time :time
    t.decimal :price, :default => 5.00
    t.datetime :created_at
    t.datetime :updated_at
    t.integer :user_id
  end
end
end
