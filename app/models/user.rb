class User < ApplicationRecord
  has_secure_password
  has_one :profiles
  validates :email, presence: true, uniqueness: true
  has_many :trips
end
