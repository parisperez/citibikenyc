class AddPermalinkDescriptionUserToExchanges < ActiveRecord::Migration
  def change
      change_table :exchanges do |t|
        t.string :name
        t.string :permalink
        t.text :description
        t.references :user
    end
  end
end
