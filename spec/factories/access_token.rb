FactoryBot.define do
  factory :access_token do
    name { 'Test Token' }

    association :user
  end
end
