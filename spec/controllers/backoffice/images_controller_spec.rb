require 'rails_helper'
require 'backoffice_controller_helper'

describe Backoffice::ImagesController, type: :controller do

  include BackofficeControllerHelper

  describe 'POST #create' do

    before(:each) do
      authenticate_reseller!
    end

    it 'creates a new image' do
      expect{
        post :create, image: {resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg")}
      }.to change(Image, :count).by(1)
    end

    it 'returns a 201 created' do
      post :create, image: {resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg")}

      expected_json = %({"id": #{Image.last.id}})

      expect(response).to have_http_status(:created)
      expect(response.body).to be_json_eql(expected_json)
    end
  end

end
