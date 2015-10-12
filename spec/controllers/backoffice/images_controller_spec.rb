require 'rails_helper'

describe Backoffice::ImagesController, type: :controller do

  describe 'POST #create' do

    before(:each) do
      username = BACKOFFICE['username']
      password = BACKOFFICE['password']
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    end

    it 'creates a new image' do
      expect{
        post :create, image: {resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg")}
      }.to change(Image, :count).by(1)
    end

    it 'returns a 201 created' do
      post :create, image: {resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg")}

      expect(response.status).to eq(201)
    end
  end

end
