require 'rails_helper'

describe Api::AuthController, type: :controller do

  describe 'POST #create' do

    context 'with valid user' do
      before do
        create(:user, provider_user_id: 'A PROVIDER USER ID')
      end

      it 'creates an authentication token' do
        expect(FacebookIdentity).to receive(:user_id_from).with('A PROVIDER TOKEN').and_return('A PROVIDER USER ID')

        post :create, provider: 'facebook', provider_token: 'A PROVIDER TOKEN'

        expect(response).to have_http_status(:created)

        expected_json = %({
          "token": "API TOKEN"
        })

        expect(response.body).to be_json_eql(expected_json)
      end
    end

  end

end
