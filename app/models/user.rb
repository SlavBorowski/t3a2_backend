class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_one :profile, dependent: :delete
  has_many :trips, dependent: :delete_all
end
