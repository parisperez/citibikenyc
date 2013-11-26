class Favorite < ActiveRecord::Base
  validates_presence_of :address, :user_id, :uniqueness => true
  belongs_to :user
end