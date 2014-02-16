class CreateTableAngels < ActiveRecord::Migration
  def change
    create_table :table_angels do |t|
      t.string :firstname, :null => false
      t.string :lastname, :null => false
      t.string :email, :null => false
      t.text :info
      t.string :twitter
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
