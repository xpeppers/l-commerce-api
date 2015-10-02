require 'rails_helper'
include Koala

describe FacebookIdentity, type: :lib, integration: true do

  context 'with a valid token' do
    it 'returns an user id' do
      expect(FacebookIdentity.user_id_from(valid_user_access_token)).to be_present
    end
  end

  context 'with an invalid token' do
    it 'returns nil' do
      expect(FacebookIdentity.user_id_from('INVALID TOKEN')).to be_nil
    end
  end

  context 'with a valid user id' do
    it 'returns the user full name' do
      expect(FacebookIdentity.full_name_from(valid_user_id)).to be_present
    end

    it 'returns user profile picture url' do
      expect(FacebookIdentity.profile_picture_url_from(valid_user_id)).to be_present
    end
  end

  context 'with an invalid user id' do
    it 'returns nil as user full name' do
      expect(FacebookIdentity.full_name_from('INVALID USER ID')).to be_nil
    end

    it 'returns nil as user profile picture url' do
      expect(FacebookIdentity.profile_picture_url_from('INVALID USER ID')).to be_nil
    end
  end

end

def valid_user_access_token
  users = Facebook::TestUsers.new(app_id: FACEBOOK_CONFIG['app_id'], secret: FACEBOOK_CONFIG['app_secret'])
  users.list.first['access_token']
end

def valid_user_id
  users = Facebook::TestUsers.new(app_id: FACEBOOK_CONFIG['app_id'], secret: FACEBOOK_CONFIG['app_secret'])
  users.list.first['id']
end
