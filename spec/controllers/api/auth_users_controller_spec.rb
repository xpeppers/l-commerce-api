require 'rails_helper'

describe Api::AuthUsersController, type: :controller do

  describe 'POST #create' do

    let (:provider_token) { 'A PROVIDER TOKEN' }
    let (:provider_user_id) { 'A PROVIDER USER ID' }
    let (:api_token) { 'API TOKEN' }

    context 'with a registered user' do
      before do
        @user = create(:user, provider_user_id: provider_user_id)

        expect(FacebookIdentity).to receive(:user_id_from).with(provider_token).and_return(provider_user_id)
      end

      it 'creates an authentication token' do
        expect(TokenGenerator).to receive(:generate).and_return(api_token)

        post :create, provider: 'facebook', provider_token: provider_token

        expect(response).to have_http_status(:created)

        expected_json = %(
          {
            "token": "#{api_token}"
          }
        )

        expect(response.body).to be_json_eql(expected_json)
      end

      context 'already authenticated' do
        before do
          @user.authenticate! api_token
        end

        it 'returns authentication token' do
          post :create, provider: 'facebook', provider_token: provider_token

          expect(response).to have_http_status(:ok)

          expected_json = %(
            {
              "token": "#{api_token}"
            }
          )

          expect(response.body).to be_json_eql(expected_json)
        end
      end
    end

    context 'with a facebook unregistered user' do
      it 'responds with unauthorized' do
        invalid_provider_token = 'INVALID PROVIDER TOKEN'

        expect(FacebookIdentity).to receive(:user_id_from).with(invalid_provider_token).and_return(nil)

        post :create, provider: 'facebook', provider_token: invalid_provider_token

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with a unregistered user' do
      it 'responds with unauthorized' do
        expect(FacebookIdentity).to receive(:user_id_from).with(provider_token).and_return('UNKNOWN PROVIDER ID')

        post :create, provider: 'facebook', provider_token: provider_token

        expect(response).to have_http_status(:unauthorized)
      end
    end

  end
end
