class AddCommenterIdandContenttoComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.integer :commenter_id  
      t.rename :comment, :content 
    end
  end
end
