require 'rails_helper'

describe Api::AuthMerchantsController, type: :controller do

  describe 'POST #create' do

    let(:api_token) { 'API TOKEN' }

    context 'with a registered user' do
      before do
        @merchant = create(:merchant, email: 'merchant@provider.com', hashed_password: 'apassword')
      end

      it 'creates an authentication token' do
        expect(TokenGenerator).to receive(:generate).and_return(api_token)

        post :create, email: 'merchant@provider.com', password: 'apassword'

        expect(response).to have_http_status(:created)

        expected_json = %({"token": "#{api_token}"})

        expect(response.body).to be_json_eql(expected_json)
      end

      context 'already authenticated' do
        before do
          @merchant.authenticate! api_token
        end

        it 'returns authentication token' do
          post :create, email: 'merchant@provider.com', password: 'apassword'

          expect(response).to have_http_status(:ok)

          expected_json = %({"token": "#{api_token}"})

          expect(response.body).to be_json_eql(expected_json)
        end
      end
    end

    context 'with a unregistered merchant' do
      it 'responds with unauthorized' do
        post :create, email: 'unknown_merchant_email', password: 'unknown_merchant_password'

        expect(response).to have_http_status(:unauthorized)
      end
    end

  end
end
