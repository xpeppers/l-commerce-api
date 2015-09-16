require 'rails_helper'

describe Api::UsersController, type: :controller do

  describe 'POST #create' do

    it 'creates a new user' do
      expect{
        post :create, email: 'email@address.com', provider: 'facebook', token: 'A VALID TOKEN'
      }.to change(User, :count).by(1)
    end

    xit 'responds with new user details' do
      post :create, email: 'email@address.com', password: 'email@address.com'

      expect(response).to have_http_status(:created)
      expect(response.header['Location']).to eq(api_user_path(User.last))

      expected_json = %(
        {
          "id": #{User.last.id},
          "email" : "email@address.com"
        }
      )

      expect(response.body).to be_json_eql(expected_json)
    end

  end

end
