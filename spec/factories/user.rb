FactoryBot.define do
  factory :user, class: 'Rapils::Models::User' do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:auth0_uid) { |n| "auth0|t#{n}" }
    # password { 'password' }
    # password_confirmation { 'password' }
    # confirmed_at { DateTime.now }
  end
end
