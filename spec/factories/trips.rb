FactoryBot.define do
  factory :trip do
    sequence :title do |n|
      "test_trip_title_#{n}"
    end
    # sequence :date do |n|
    #   "202#{n}-10-10"
    # end
    date{"2021-01-01"}
    city{"city"}
    association :user
  end

  trait :invalid_trip do
    title {nil}
  end
end
