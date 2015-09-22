require 'rails_helper'

describe Api::AuthController, type: :controller do

  describe 'POST #create' do

    context 'with valid user' do
      PROVIDER_TOKEN = 'A PROVIDER TOKEN'
      PROVIDER_USER_ID = 'A PROVIDER USER ID'

      before do
        create(:user, provider_user_id: PROVIDER_USER_ID)
      end

      it 'creates an authentication token' do
        expect(FacebookIdentity).to receive(:user_id_from).with(PROVIDER_TOKEN).and_return(PROVIDER_USER_ID)

        post :create, provider: 'facebook', provider_token: PROVIDER_TOKEN

        expect(response).to have_http_status(:created)

        expected_json = %({
          "token": "API TOKEN"
        })

        expect(response.body).to be_json_eql(expected_json)
      end
    end

    context 'with invalid user' do
      it 'responds with unauthorized' do
        INVALID_PROVIDER_TOKEN = 'INVALID PROVIDER TOKEN'

        expect(FacebookIdentity).to receive(:user_id_from).with(INVALID_PROVIDER_TOKEN).and_return(nil)

        post :create, provider: 'facebook', provider_token: INVALID_PROVIDER_TOKEN

        expect(response).to have_http_status(:unauthorized)
      end
    end

  end

end
