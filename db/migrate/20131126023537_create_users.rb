class CreateUsers < ActiveRecord::Migration
def up
    create_table :users do |t|
      t.string :username, :null => false
      t.string :email, :null => false, index: true, unique: true
      t.string :password_digest, :null => false
     t.datetime "created_at"
     t.datetime "updated_at"
    end
  end

  def down
    drop_table :users
    end
end
