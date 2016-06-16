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
            "id": #{@second_offer.id},
            "description": "MyText",
            "image_url": null,
            "original_price": "10.99",
            "price": "9.99",
            "reservation_price": "2.00",
            "title": "MyString",
            "latitude": 46.0667,
            "longitude": 11.1167,
            "url": "http://127.0.0.1:3000/frontend/offers/#{@second_offer.id}"
          },
          {
            "id": #{@first_offer.id},
            "description": "MyText",
            "image_url": null,
            "original_price": null,
            "price": "9.99",
            "reservation_price": "2.00",
            "title": "MyString",
            "latitude": 46.0667,
            "longitude": 11.1167,
            "url": "http://127.0.0.1:3000/frontend/offers/#{@first_offer.id}"
          }
        ]
      )

      expect(response.body).to be_json_eql(expected_json)
    end
  end


  describe 'GET #index?lat=46.076389&lon=11.121285' do
    before do
      @merchat_near = create :merchant, latitude: 46.0760398, longitude: 11.1217031
      @merchat_far = create :merchant, latitude: 46.077290, longitude: 11.1287953
      @first_offer = create :offer, merchant: @merchat_near
      @second_offer = create :offer, original_price: 10.99, merchant: @merchat_far

      params = {
        lat: 46.076389,
        lon: 11.121285
      }
      get :index, params
    end

    it 'returns two offers' do
      expect(response).to have_http_status(:ok)

      expected_json = %(
        [
          {
            "id": #{@first_offer.id},
            "description": "MyText",
            "image_url": null,
            "original_price": null,
            "price": "9.99",
            "reservation_price": "2.00",
            "title": "MyString",
            "latitude": 46.0760398,
            "longitude": 11.1217031,
            "url": "http://127.0.0.1:3000/frontend/offers/#{@first_offer.id}"
          },
          {
            "id": #{@second_offer.id},
            "description": "MyText",
            "image_url": null,
            "original_price": "10.99",
            "price": "9.99",
            "reservation_price": "2.00",
            "title": "MyString",
            "latitude": 46.077290,
            "longitude": 11.1287953,
            "url": "http://127.0.0.1:3000/frontend/offers/#{@second_offer.id}"
          }
        ]
      )

      expect(response.body).to be_json_eql(expected_json)
    end
  end


  describe 'GET #show' do

    let(:image) { create :image, resource: File.open("#{Rails.root}/spec/fixtures/images/carne1.jpg") }
    let(:image_gallery) { create :image_gallery, images: [image] }
    let(:offer) { create :offer, original_price: 10.44, image_gallery: image_gallery }

    it 'returns offer details' do
      get :show, id: offer

      expect(response).to have_http_status(:ok)

      expected_json = %(
        {
          "id": #{offer.id},
          "description": "#{offer.description}",
          "image_gallery": ["http://127.0.0.1:3000/uploads/image/resource/1/carne1.jpg"],
          "original_price": "#{offer.original_price}",
          "price": "#{offer.price}",
          "title": "#{offer.title}",
          "reservation_price": "2.00",
          "merchant": "#{offer.merchant.name}",
          "url": "http://127.0.0.1:3000/frontend/offers/#{offer.id}",
          "address":
          {
            "street": "#{offer.merchant.street}",
            "zip_code": "#{offer.merchant.zip_code}",
            "city": "#{offer.merchant.city}",
            "latitude": #{offer.merchant.latitude},
            "longitude": #{offer.merchant.longitude}
          },
          "telephone": "#{offer.merchant.telephone}",
          "email": "#{offer.merchant.email}",
          "web_site": "#{offer.merchant.web_site}",
          "facebook": "#{offer.merchant.facebook}",
          "twitter": "#{offer.merchant.twitter}"
        }
      )

      expect(response.body).to be_json_eql(expected_json)
    end
  end
end
