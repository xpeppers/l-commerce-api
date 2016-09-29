require 'rails_helper'

describe Api::OrdersController, type: :controller do

  context 'for an authenticated user' do
    let(:user) { create(:user, token: 'ANY TOKEN') }
    let(:offer) { create(:offer) }

    before do
      request.headers['Authorization'] = "Token token=#{user.token}"
    end

    describe 'POST #create' do
      it 'creates a new order' do
        expect{
          post :create, offer_ids: [offer]
        }.to change(Order, :count).by(1)
      end

      it 'cannot create an empty order' do
        expect{
          post :create, offer_ids: []
        }.to change(Order, :count).by(0)
      end

      it 'responds with order details' do
        post :create, offer_ids: [offer]

        expect(response).to have_http_status(:created)
        expect(response.header['Location']).to eq(api_order_path(Order.last))

        expected_json = %({
          "id": #{Order.last.id},
          "user_id": #{user.id},
          "offers": [
            {
              "id": #{offer.id},
              "description": "MyText",
              "image_url": null,
              "original_price": null,
              "reservation_price": "2.00",
              "price": "9.99",
              "title": "MyString",
              "latitude": 46.0667,
              "longitude": 11.1167,
              "url": "http://127.0.0.1:3000/frontend/offers/#{offer.id}"
            }
          ],
          "status": "pending",
          "coupon": null
        })

        expect(response.body).to be_json_eql(expected_json)
      end
    end

    describe 'GET #show' do
      context "with a 'pending' order" do
        let(:order) { create(:order, user: user, offers: [offer]) }

        it 'responds with coupon details' do
          get :show, id: order

          expect(response).to have_http_status(:ok)

          expected_json = %({
            "id": #{order.id},
            "user_id": #{user.id},
            "offers": [
              {
                "id": #{offer.id},
                "description": "MyText",
                "image_url": null,
                "original_price": null,
                "price": "9.99",
                "reservation_price": "2.00",
                "title": "MyString",
                "latitude": 46.0667,
                "longitude": 11.1167,
                "url": "http://127.0.0.1:3000/frontend/offers/#{offer.id}"
              }
            ],
            "status": "pending",
            "coupon": null
          })

          expect(response.body).to be_json_eql(expected_json)
        end
      end

      context "with a 'captured' order" do
        let(:coupon) { create(:coupon) }
        let(:order) { create(:captured_order, user: user, offers: [offer], coupon: coupon) }

        it 'responds with coupon details' do
          get :show, id: order

          expect(response).to have_http_status(:ok)

          expected_json = %({
            "id": #{order.id},
            "user_id": #{user.id},
            "offers": [
              {
                "id": #{offer.id},
                "description": "MyText",
                "image_url": null,
                "original_price": null,
                "price": "9.99",
                "reservation_price": "2.00",
                "title": "MyString",
                "latitude": 46.0667,
                "longitude": 11.1167,
                "url": "http://127.0.0.1:3000/frontend/offers/#{offer.id}"
              }
            ],
            "status": "captured",
            "coupon": {
              "id": #{coupon.id},
              "code": "#{coupon.code}"
            }
          })

          expect(response.body).to be_json_eql(expected_json)
        end
      end

    end
  end

  context 'for an unauthenticated user' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer) }

    describe 'POST #create' do
      context 'without token' do
        it 'responds with unauthorized' do
          post :create, offer_ids: [offer]

          expect(response).to have_http_status(:unauthorized)
        end
      end

      describe 'with invalid token' do
        before do
          request.headers['Authorization'] = 'Token token=INVALID_TOKEN'
        end

        it 'responds with unauthorized' do
          post :create, offer_ids: [offer]

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    describe 'GET #show' do
      let(:order) { create(:order, user: user, offers: [offer]) }

      it 'responds with unauthorized' do
        get :show, id: order

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

end
