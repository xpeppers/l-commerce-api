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

        it 'responds with a list of bought offers' do
          create(:captured_order, user: user, offers: [first_offer, second_offer], coupon: first_coupon)
          create(:captured_order, user: user, offers: [third_offer], coupon: second_coupon)
          create(:order, user: user, offers: [first_offer])

          get :index

          expect(response).to have_http_status(:ok)

          expected_json = %([
            {
              "id": #{first_offer.id},
              "title": "#{first_offer.title}",
              "description": "#{first_offer.description}",
              "image_url": "#{first_offer.image_url}",
              "status": "unused"
            },
            {
              "id": #{second_offer.id},
              "title": "#{second_offer.title}",
              "description": "#{second_offer.description}",
              "image_url": "#{second_offer.image_url}",
              "status": "unused"
            },
            {
              "id": #{third_offer.id},
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
  end

  context 'for an unauthenticated user' do
    describe 'GET #index' do
      it 'responds with unauthorized' do
        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
