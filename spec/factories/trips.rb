FactoryBot.define do
  factory :trip do
    sequence :title do |n|
      "test_trip_title_#{n}"
    end
    date{"2021-01-01"}
    city{"city"}
    association :user
  end

  trait :invalid_trip do
    title {nil}
  end
end
