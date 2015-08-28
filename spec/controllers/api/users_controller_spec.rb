require 'rails_helper'

describe Api::UsersController, type: :controller do

  describe 'POST #create' do

    it 'creates a new user' do
      expect{
	post :create, email: 'email@address.com', password: 'email@address.com'
      }.to change(User, :count).by(1)
    end

    it 'responds with new user details' do
      post :create, email: 'email@address.com', password: 'email@address.com'

      expect(response).to have_http_status(:created)
      expect(json).to eq({'email' => 'email@address.com'})
      expect(response.header['Location']).to eq(api_user_path(User.last))
    end

  end

end
