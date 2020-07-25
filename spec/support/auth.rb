module AuthControllerHelpers
  def login_as(user)
    sign_in user
  end

  def api_call_as(user)
    access_token = user.access_tokens.create(name: 'Test Session', created_at: 5.minutes.ago, expires_at: 1.hour.from_now)
    allow(controller).to receive(:access_token).and_return access_token
  end
end

RSpec.configure do |config|
  config.include AuthControllerHelpers, type: :controller
end
