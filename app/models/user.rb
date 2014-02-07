class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: true, uniqueness: true
  letsrate_rateable
  letsrate_rater
  acts_as_commentable
  has_many :favorites
  has_many :received_exchanges,
  :class_name => 'Exchange',
  :primary_key => 'user_id',
  :foreign_key => 'vendor_id'
end