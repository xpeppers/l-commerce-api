require 'rails_helper'

describe Api::DeviceTokenController, type: :controller do
    describe 'GET #index' do
      before do
        @first = create :device_token
        @second = create :device_token, platform: "android"

        get :index
      end

      it 'return two device tokens' do
          expect(response).to have_http_status(:ok)

          expected_json = %(
            [
              {
                "token": "MyToken",
                "platform": "MyPlatform"
              },
              {
                "token": "MyToken",
                "platform": "android"
              }
            ]
          )

         expect(response.body).to be_json_eql(expected_json)
    end
  end

  describe 'POST #create' do

      let(:token) { 'MyToken' }
      let(:platform) { 'android' }
      
      it 'returns created device token' do
          post :create, token: token, platform: platform
          expect(response).to have_http_status(:created)

          expected_json = %({"token": "#{token}", "platform": "#{platform}"})

          expect(response.body).to be_json_eql(expected_json)

      end

  end

end
