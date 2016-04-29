require 'rails_helper'

describe Api::DeviceTokenController, type: :controller do
    describe 'GET #index' do
      before do
        @first = create :device_token

        get :index
      end

      it 'return 1 device tokens' do
          expect(response).to have_http_status(:ok)

          expected_json = %(
            [
              {
                "token": "MyToken",
                "platform": "MyPlatform"
              }
            ]
          )

         expect(response.body).to be_json_eql(expected_json)
    end
  end

  describe 'POST #create' do

      let(:token) { 'MyToken' }
      let(:platform) { 'MyPlatform' }

      it 'returns created device token' do
          post :create, token: token, platform: platform
          expect(response).to have_http_status(:created)

          expected_json = %({"token": "#{token}", "platform": "#{platform}"})

          expect(response.body).to be_json_eql(expected_json)

      end

  end

end
