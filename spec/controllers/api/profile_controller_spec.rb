require 'rails_helper'

describe Api::ProfileController, type: :controller do

  context 'for an authenticated user' do
    let(:user) { create(:user, token: 'ANY TOKEN') }

    describe 'GET #show' do
      context 'with a valid user id' do
        it 'returns user profile' do
          expect(FacebookIdentity).to receive(:full_name_from).with(user.provider_user_id).and_return('FULL NAME')
          expect(FacebookIdentity).to receive(:profile_picture_url_from).with(user.provider_user_id).and_return('PICTURE URL')

          request.headers['Authorization'] = "Token token=#{user.token}"
          get :show
          expect(response).to have_http_status(:success)

          expected_json = %(
            {
              "full_name": "FULL NAME",
              "picture_url": "PICTURE URL"
            }
          )

          expect(response.body).to be_json_eql(expected_json)
        end
      end

      context 'with an invalid user id' do
        it 'returns null fields' do
          expect(FacebookIdentity).to receive(:full_name_from).with(user.provider_user_id).and_return(nil)
          expect(FacebookIdentity).to receive(:profile_picture_url_from).with(user.provider_user_id).and_return(nil)

          request.headers['Authorization'] = "Token token=#{user.token}"
          get :show
          expect(response).to have_http_status(:success)

          expected_json = %(
            {
              "full_name": null,
              "picture_url": null
            }
          )

          expect(response.body).to be_json_eql(expected_json)
        end
      end
    end
  end

  context 'for an unauthenticated user' do

    describe 'GET #show' do
      it 'returns unauthorized' do
        get :show
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
