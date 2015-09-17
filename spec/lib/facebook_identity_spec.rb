require 'rails_helper'

describe FacebookIdentity, type: :lib do

  it 'returns an user id for a valid token' do
    expect(FacebookIdentity.user_id_from(get_token)).to_not be_nil
  end

  it 'return nil for an invalid token' do
    expect(FacebookIdentity.user_id_from('INVALID TOKEN')).to be_nil
  end
end


def get_token
  app_id = 'app_id'
  app_secret = 'app_secret'
  @test_users_api = Koala::Facebook::TestUsers.new(app_id: app_id, secret: app_secret)
  test_users = @test_users_api.list
  test_user = test_users.first
  test_user['access_token']
end
