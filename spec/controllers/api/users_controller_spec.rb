require 'rails_helper'

describe Api::UsersController, type: :controller do

  describe 'POST #create' do

    context 'with a valid provider token' do

      before do
        expect(FacebookIdentity).to receive(:user_id_from).with('ANY TOKEN').and_return('AN ID')
      end

      it 'creates a new user' do
        expect{
          post :create, email: 'email@address.com', provider: 'facebook', provider_token: 'ANY TOKEN'
        }.to change(User, :count).by(1)
      end

      it 'responds with new user details' do
        post :create, email: 'email@address.com', provider: 'facebook', provider_token: 'ANY TOKEN'

        expect(response).to have_http_status(:created)
        expect(response.header['Location']).to eq(api_user_path(User.last))

        expected_json = %(
          {
            "id": #{User.last.id},
            "email": "email@address.com"
          }
        )
        puts expected_json
        expect(response.body).to be_json_eql(expected_json)
      end

      it 'responds with user details if user already exists' do
        user = create(:user, provider_user_id: 'AN ID')
        post :create, email: 'MyString', provider: 'facebook', provider_token: 'ANY TOKEN'

        expect(response).to have_http_status(200)
        expect(response.header['Location']).to eq(api_user_path(user))

        expected_json = %(
          {
            "id": #{user.id},
            "email": "#{user.email}"
          }
        )

        expect(response.body).to be_json_eql(expected_json)
      end
    end

    context 'with an invalid provider token' do

      before do
        expect(FacebookIdentity).to receive(:user_id_from).with('AN INVALID TOKEN').and_return(nil)
      end

      it 'responds with unauthorized' do
        post :create, email: 'email@address.com', provider: 'facebook', provider_token: 'AN INVALID TOKEN'

        expect(response).to have_http_status(:unauthorized)
      end

    end

    context 'user creation with email and password' do
        it 'responds with new user details' do
          post :create, { email: 'email@address.com', provider_token: 'mypass', provider: "email" }

          expect(response).to have_http_status(:created)
          expect(response.header['Location']).to eq(api_user_path(User.last))

          expected_json = %(
            {
              "id": #{User.last.id},
              "email": "email@address.com"
            }
          )
          expect(response.body).to be_json_eql(expected_json)
        end

        it 'responds with unauthorized when password not setted' do
          post :create, email: 'email@address.com'

          expect(response).to have_http_status(:unauthorized)
        end
    end

    context 'user temporary login with email and  provided code' do
      it 'responds ok if validity date is >= now' do
        post :create, { email: 'email@address.com', provider_token: 'mypass', provider: "email" }
        temp_code = TemporaryCode.create({user_id: User.last.id})
        expect(temp_code.code.present?).to eq(true)

        post :temporary_login,  { email: 'email@address.com', provider_token: temp_code.code, provider: "email" }
        expect(response).to have_http_status(:ok)
 
        expect(TemporaryCode.last.present?).to eq(false)

      end

      it 'responds unauthorized if validity date is <= now' do
      end
    end
  end




end
