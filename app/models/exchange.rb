class Exchange < ActiveRecord::Base
  validates :date, :time, :price, presence: true
  belongs_to :requester,
    :class_name => 'User',
    :primary_key => 'user_id',
    :foreign_key => 'vendor_id'
  belongs_to :vendor,
    :class_name => 'User',
    :primary_key => 'user_id',
    :foreign_key => 'vendor_id'   
end


