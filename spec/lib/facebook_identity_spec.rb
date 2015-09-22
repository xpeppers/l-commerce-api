require 'rails_helper'
include Koala

describe FacebookIdentity, type: :lib, integration: true do

  context 'with a valid token' do
    it 'returns an user id' do
      expect(FacebookIdentity.user_id_from(valid_user_access_token)).to_not be_nil
    end
  end

  context 'with an invalid token' do
    it 'returns nil' do
      expect(FacebookIdentity.user_id_from('INVALID TOKEN')).to be_nil
    end
  end

end


def valid_user_access_token
  users = Facebook::TestUsers.new(app_id: FACEBOOK_CONFIG['app_id'], secret: FACEBOOK_CONFIG['app_secret'])
  users.list.first['access_token']
end
