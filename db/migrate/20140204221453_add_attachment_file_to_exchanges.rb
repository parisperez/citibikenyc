class AddAttachmentFileToExchanges < ActiveRecord::Migration
  def self.up
    change_table :exchanges do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :exchanges, :file
  end
end
