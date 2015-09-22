require 'rails_helper'

describe Api::AuthController, type: :controller do

  describe 'POST #create' do

    context 'with valid user' do
      before do
        create(:user, provider_user_id: 'A PROVIDER USER ID')
      end

      it 'creates an authentication token' do
        expect(FacebookIdentity).to receive(:user_id_from).with('ANY TOKEN').and_return('A PROVIDER USER ID')

        post :create, provider: 'facebook', provider_token: 'ANY TOKEN'

        expect(response).to have_http_status(:created)
      end
    end

    # it 'responds with new user details' do
    #   post :create, email: 'email@address.com', password: 'email@address.com'

    #   expect(response).to have_http_status(:created)
    #   expect(response.header['Location']).to eq(api_user_path(User.last))

    #   expected_json = %({
    #     "id": #{User.last.id},
    #     "email" : "email@address.com"
    #   })

    #   expect(response.body).to be_json_eql(expected_json)
    # end

  end

end
