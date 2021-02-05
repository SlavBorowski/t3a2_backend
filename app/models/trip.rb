class Trip < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :date, presence: true
  validates :city, presence: true

  # validate :trip_date_cannot_be_in_the_past

  # def trip_date_cannot_be_in_the_past
  #   errors.add(:date, "can't be in the past") if
  #     !date.blank? and date < Date.today
  # end

  has_many :itinerary_items, dependent: :delete_all
end
