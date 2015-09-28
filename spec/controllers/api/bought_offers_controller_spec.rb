require 'rails_helper'

describe Api::BoughtOffersController, type: :controller do

  context 'for an authenticated user' do
    let(:user) { create(:user, token: 'ANY TOKEN') }

    before do
      request.headers['Authorization'] = "Token token=#{user.token}"
    end

    describe 'GET #index' do
      context 'with no bought offers' do
        it 'responds with an empy list' do
          get :index

          expect(response).to have_http_status(:ok)
          expect(response.body).to be_json_eql('[]')
        end
      end

      context 'with bought offers' do
        let(:first_offer) { create(:offer) }
        let(:second_offer) { create(:offer) }
        let(:third_offer) { create(:offer) }

        let(:first_coupon) { create(:coupon, code: 'XXX') }
        let(:second_coupon) { create(:coupon, code: 'YYY') }

        let(:first_order) { create(:captured_order, user: user, offers: [first_offer, second_offer], coupon: first_coupon) }
        let(:second_order) { create(:captured_order, user: user, offers: [third_offer], coupon: second_coupon) }

        it 'responds with a list of bought offers' do
          bought_offers = first_order.bought_offers + second_order.bought_offers
          create(:order, user: user, offers: [first_offer])

          get :index

          expect(response).to have_http_status(:ok)

          expected_json = %([
            {
              "id": #{bought_offers.first.id},
              "title": "#{first_offer.title}",
              "description": "#{first_offer.description}",
              "image_url": "#{first_offer.image_url}",
              "status": "unused"
            },
            {
              "id": #{bought_offers.second.id},
              "title": "#{second_offer.title}",
              "description": "#{second_offer.description}",
              "image_url": "#{second_offer.image_url}",
              "status": "unused"
            },
            {
              "id": #{bought_offers.third.id},
              "title": "#{third_offer.title}",
              "description": "#{third_offer.description}",
              "image_url": "#{third_offer.image_url}",
              "status": "unused"
            }
          ])

          expect(response.body).to be_json_eql(expected_json)
        end
      end
    end

    describe 'GET #show' do
      context 'with no bought offers' do
        it 'responds 404' do
          get :show, id: 1

          expect(response).to have_http_status(:not_found)
        end
      end

      context 'with bought offer' do
        let(:offer) { create(:offer) }
        let(:coupon) { create(:coupon, code: 'XXX') }
        let(:order) { create(:captured_order, user: user, offers: [offer], coupon: coupon) }

        it 'responds with bought offer details' do
          bought_offer = order.bought_offers.first

          get :show, id: bought_offer.id

          expect(response).to have_http_status(:ok)

          expected_json = %({
            "id": #{bought_offer.id},
            "coupon": {
                "id": #{coupon.id},
                "code": "#{coupon.code}"
            },
            "title": "#{bought_offer.title}",
            "description": "#{bought_offer.description}",
            "price": "#{bought_offer.price}",
            "image_url": "#{bought_offer.image_url}",
            "merchant": "#{bought_offer.merchant}",
            "status": "#{bought_offer.status}",
            "address":
            {
              "street": "#{bought_offer.street}",
              "zip_code": "#{bought_offer.zip_code}",
              "city": "#{bought_offer.city}",
              "latitude": "#{bought_offer.latitude}",
              "longitude": "#{bought_offer.longitude}"
            },
            "telephone": "#{bought_offer.telephone}",
            "email": "#{bought_offer.email}",
            "web_site": "#{bought_offer.web_site}"
          })

          expect(response.body).to be_json_eql(expected_json)
        end
      end
    end
  end

  context 'for an unauthenticated user' do
    describe 'GET #index' do
      it 'responds with unauthorized' do
        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'GET #show' do
      it 'responds with unauthorized' do
        get :show, id: 1

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
