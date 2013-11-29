class Exchange < ActiveRecord::Base
  validates :is_bike, :date, :time, presence: true
  has_and_belongs_to_many :users
end