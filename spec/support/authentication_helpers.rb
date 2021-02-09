module AuthenticationHelpers
  def authenticated_header
    user = FactoryBot.create(:user)
    authenticate_user(user)
  end

  def authenticate_user(user)
    token = Knock::AuthToken.new(payload: {sub: user.id}).token

    { 'Authorization': "Bearer #{token}"}
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :request
end