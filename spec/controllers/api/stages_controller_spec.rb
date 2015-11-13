require 'rails_helper'

describe Api::StagesController, type: :controller do


  let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }
  let(:path)  { create :path, image: image }
  let(:merchant) { create :merchant }

  describe 'GET #index' do

    before do
      @first_stage = create :stage, image: image, path: path, merchant: merchant
      @second_stage = create :stage, image: image, path: path, merchant: merchant

      get :index, path_id: path.id
    end

    it 'returns two stages' do
      expect(response).to have_http_status(:ok)

      expected_json = %(
        [
          {
            "id": #{@first_stage.id},
            "title": "MyString",
            "image_url": "http://127.0.0.1:3000/uploads/image/resource/#{image.id}/carne1.jpg"
          },
          {
            "id": #{@second_stage.id},
            "title": "MyString",
            "image_url": "http://127.0.0.1:3000/uploads/image/resource/#{image.id}/carne1.jpg"
          }
        ]
      )

      expect(response.body).to be_json_eql(expected_json)
    end
  end

  describe 'GET #show' do

    let(:stage) { create :stage, image: image, path: path, merchant: merchant }

    it 'returns stage details' do
      get :show, path_id: path.id, id: stage.id

      expect(response).to have_http_status(:ok)

      expected_json = %(
        {
          "id": #{stage.id},
          "title": "#{stage.title}",
          "address": {
            "city": "A CITY",
            "latitude": 46.0667,
            "longitude": 11.1167,
            "street": "A STREET",
            "zip_code": "A ZIP CODE"
          },
          "description": "#{stage.description}",
          "image_url": "http://127.0.0.1:3000/uploads/image/resource/#{image.id}/carne1.jpg",
          "merchant": "A NAME",
          "merchant_image_url": null
        }
      )

      expect(response.body).to be_json_eql(expected_json)
    end
  end
end
