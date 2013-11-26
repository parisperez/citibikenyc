class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :favorites
  has_secure_password
end