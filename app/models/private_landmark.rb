class PrivateLandmark < ApplicationRecord
  belongs_to :user
  has_many_attached :image

  validates :title, presence: true, uniqueness: true
  validates :city, presence: true

end
