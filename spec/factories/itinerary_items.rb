FactoryBot.define do
  factory :itinerary_item do
    name{"item_name"}
    association :trip
  end
end
