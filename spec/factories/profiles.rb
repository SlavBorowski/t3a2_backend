FactoryBot.define do
  factory :profile do
    name{"user_name"}
    association :user
  end
end