require 'rails_helper'

describe Api::OffersController, type: :controller do

  describe 'GET #index' do
    before do
      @first_offer = create :offer
      @second_offer = create :offer, original_price: 10.99

      get :index
    end

    it 'returns two offers' do
      expect(response).to have_http_status(:ok)

      expected_json = %(
        [
          {
            "id": 1,
            "description": "MyText",
            "image_url": "MyString",
            "original_price": null,
            "price": "9.99",
            "title": "MyString"
          },
          {
            "id": 2,
            "description": "MyText",
            "image_url": "MyString",
            "original_price": "10.99",
            "price": "9.99",
            "title": "MyString"
          }
        ]
      )

      expect(response.body).to be_json_eql(expected_json)
    end
  end

  describe 'GET #show' do

    let(:offer) { create :offer, original_price: 10.44 }

    it 'returns offer details' do
      get :show, id: offer

      expect(response).to have_http_status(:ok)

      expected_json = %(
        {
          "id": #{offer.id},
          "description": "#{offer.description}",
          "image_url": "#{offer.image_url}",
          "original_price": "#{offer.original_price}",
          "price": "#{offer.price}",
          "title": "#{offer.title}",
          "merchant": "#{offer.merchant}",
          "address":
          {
            "street": "#{offer.street}",
            "zip_code": "#{offer.zip_code}",
            "city": "#{offer.city}",
            "latitude": "#{offer.latitude}",
            "longitude": "#{offer.longitude}"
          },
          "telephone": "#{offer.telephone}",
          "email": "#{offer.email}",
          "web_site": "#{offer.web_site}"
        }
      )

      expect(response.body).to be_json_eql(expected_json)
    end
  end
end
