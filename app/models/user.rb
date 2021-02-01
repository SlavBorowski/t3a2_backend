class User < ApplicationRecord
  has_secure_password
  has_one :profiles
  validates :email, presence: true, uniqueness: true
end
