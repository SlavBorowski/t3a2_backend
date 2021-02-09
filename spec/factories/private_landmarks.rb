FactoryBot.define do
  factory :private_landmark do
    title{"test_landmark_title"}
    city{"city"}
    association :user
  end
end
