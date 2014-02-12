class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :username, uniqueness: true, if: -> { self.username.present? }     
  validates :email, presence: true, uniqueness: true
  validates :phone_number,  :numericality => true,
                     :length => { :minimum => 10, :maximum => 10, :message => 'Must be 10 numbers.' }
  letsrate_rateable
  letsrate_rater
  has_many :comments, as: :commentable  
  has_many :favorites
  has_many :received_exchanges,
  :class_name => 'Exchange',
  :primary_key => 'user_id',
  :foreign_key => 'vendor_id'
end