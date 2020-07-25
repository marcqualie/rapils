FactoryBot.define do
  factory :access_token, class: 'Rapils::Models::AccessToken' do
    name { 'Test Token' }

    association :user
  end
end
