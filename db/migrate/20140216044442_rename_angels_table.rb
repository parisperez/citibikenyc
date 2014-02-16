class RenameAngelsTable < ActiveRecord::Migration
  def change
    rename_table :table_angels, :angels
  end
end
