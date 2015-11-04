require 'rails_helper'

describe Api::PathsController, type: :controller do

  describe 'GET #index' do

    let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }

    before do

      @first_path = create :path, image: image
      @second_path = create :path, image: image

      get :index
    end

    it 'returns two paths' do
      expect(response).to have_http_status(:ok)

      expected_json = %(
        [
          {
            "id": #{@first_path.id},
            "title": "MyString",
            "image_url": "http://127.0.0.1:3000/uploads/image/resource/1/carne1.jpg"
          },
          {
            "id": #{@second_path.id},
            "title": "MyString",
            "image_url": "http://127.0.0.1:3000/uploads/image/resource/1/carne1.jpg"
          }
        ]
      )

      expect(response.body).to be_json_eql(expected_json)
    end
  end

  describe 'GET #show' do

    let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }
    let(:path) { create :path, image: image }

    it 'returns path details' do
      get :show, id: path

      expect(response).to have_http_status(:ok)

      expected_json = %(
        {
          "id": #{path.id},
          "title": "#{path.title}",
          "description": "#{path.description}",
          "image_url": "http://127.0.0.1:3000/uploads/image/resource/1/carne1.jpg",
          "stages": []
        }
      )

      expect(response.body).to be_json_eql(expected_json)
    end
  end
end
