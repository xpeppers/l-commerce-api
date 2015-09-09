require 'rails_helper'

describe Api::OrdersController, type: :controller do

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer) }

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
          #{offer.to_json(except: [:created_at, :updated_at])}
        ],
        "status": "pending",
        "coupon": null
      })

      expect(response.body).to be_json_eql(expected_json)
    end
  end

  describe 'GET #show' do
    context "when status is 'captured'" do

      let(:user) { create(:user) }
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
            #{offer.to_json(except: [:created_at, :updated_at])}
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
