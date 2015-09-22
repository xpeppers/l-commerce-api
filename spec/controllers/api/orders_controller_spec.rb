require 'rails_helper'

describe Api::OrdersController, type: :controller do

  describe 'POST #create' do

    context 'with an authenticated user' do
      let(:user) { create(:user, token: 'ANY TOKEN') }
      let(:offer) { create(:offer) }

      before do
        request.headers['Authorization'] = "Token token=#{user.token}"
      end

      it 'creates a new order' do
        expect{
          post :create, user_id: user, offer_ids: [offer]
        }.to change(Order, :count).by(1)
      end

      it 'responds with order details' do
        post :create, user_id: user, offer_ids: [offer]

        expect(response).to have_http_status(:created)
        expect(response.header['Location']).to eq(api_order_path(Order.last))

        expected_json = %({
          "id": #{Order.last.id},
          "user_id": #{user.id},
          "offers": [
            {
              "id": #{offer.id},
              "description": "MyText",
              "image_url": "MyString",
              "original_price": null,
              "price": "9.99",
              "title": "MyString"
            }
          ],
          "status": "pending",
          "coupon": null
        })

        expect(response.body).to be_json_eql(expected_json)
      end
    end

    context 'with an unauthenticated user' do
      let(:user) { create(:user) }
      let(:offer) { create(:offer) }

      describe 'without token' do
        it 'responds with unauthorized' do
          post :create, user_id: user, offer_ids: [offer]

          expect(response).to have_http_status(:unauthorized)
        end
      end

      describe 'with invalid token' do
        before do
          request.headers['Authorization'] = 'Token token=INVALID_TOKEN'
        end

        it 'responds with unauthorized' do
          post :create, user_id: user, offer_ids: [offer]

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'GET #show' do
    context 'with an authenticated user' do

      let(:user) { create(:user, token: 'ANY TOKEN') }

      before do
        request.headers['Authorization'] = "Token token=#{user.token}"
      end

      describe "with a 'captured' order" do
        let(:offer) { create(:offer) }
        let(:coupon) { create(:coupon, code: 'XXX') }
        let(:order) { create(:captured_order, user: user, offers: [offer], coupon: coupon) }

        it 'responds with coupon details' do
          get :show, id: order

          expect(response).to have_http_status(:ok)

          expected_json = %({
            "id": #{order.id},
            "user_id": #{user.id},
            "offers": [
              {
                "description": "MyText",
                "image_url": "MyString",
                "original_price": null,
                "price": "9.99",
                "title": "MyString"
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

    context 'with an unautheticated user' do

      let(:user) { create(:user) }
      let(:offer) { create(:offer) }
      let(:order) { create(:order, user: user, offers: [offer]) }

      it 'responds with unauthorized' do
        get :show, id: order

        expect(response).to have_http_status(:unauthorized)
      end

    end
  end

end
