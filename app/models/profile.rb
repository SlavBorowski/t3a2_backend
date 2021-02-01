class Profile < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  belongs_to :user
end
