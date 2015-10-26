require 'rails_helper'

describe Api::SoldOffersController, type: :controller do

  context 'for an authenticated merchant' do
    let(:merchant) { create(:merchant, token: 'ANY TOKEN') }

    before do
      request.headers['Authorization'] = "Token token=#{merchant.token}"
    end

    describe 'GET #index' do
      context 'with no sold offers' do
        it 'responds with an empy list' do
          get :index

          expect(response).to have_http_status(:ok)
          expect(response.body).to be_json_eql('[]')
        end
      end

      context 'with sold offers' do
        let(:user) { create(:user) }
        let(:offer) { create(:offer, merchant: merchant) }
        let(:coupon) { create(:coupon) }

        it 'responds with a list of sold offers' do
          create(:captured_order, user: user, offers: [offer], coupon: coupon)

          sold_offers = BoughtOffer.joins(:merchant).where(merchants: {id: merchant.id})

          get :index

          expect(response).to have_http_status(:ok)

          expected_json = %([
            {
              "id": #{sold_offers.first.id},
              "title": "#{offer.title}",
              "buyer_email": "#{user.email}",
              "purchase_date": "#{sold_offers.first.purchase_date}",
              "coupon": {
                "id": #{coupon.id},
                "code": "#{coupon.code}"
              },
              "status": "#{sold_offers.first.status}"
            }
          ])

          expect(response.body).to be_json_eql(expected_json)
        end

      end
    end

    describe 'PUT #update' do
      let(:user) { create(:user) }
      let(:offer) { create(:offer, merchant: merchant) }
      let(:coupon) { create(:coupon) }

      it 'updates the status of a sold offer' do
        create(:captured_order, user: user, offers: [offer], coupon: coupon)

        sold_offer = merchant.sold_offers.first

        put :update, id: sold_offer, status: 'used'

        expect(response).to have_http_status(:ok)

        expected_json = %({
          "id": #{sold_offer.id},
          "status": "used"
        })

        expect(response.body).to be_json_eql(expected_json)
      end

      context 'for a unexisting sold offer' do
        it 'responds with not found' do
          put :update, id: 999, status: 'used'

          expect(response).to have_http_status(:not_found)
        end
      end

    end
  end

  context 'for an unauthenticated merchant' do
    describe 'GET #index' do
      it 'responds with unauthorized' do
        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'PUT #update' do
      it 'responds with unauthorized' do
        put :update, id: 999

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
