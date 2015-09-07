require 'rails_helper'

describe Api::PaymentsController, type: :controller do

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer) }
    let(:order) { create(:order, user: user, offers: [offer]) }

    it 'creates a new payment' do
      expect{
        post :create, order_id: order, paypal_payment_token: 'ANY TOKEN'
      }.to change(Payment, :count).by(1)
    end

    it 'responds with payment details' do
      post :create, order_id: order, paypal_payment_token: 'ANY TOKEN'

      expect(response).to have_http_status(:created)
      expect(response.header['Location']).to eq(api_order_payment_path(order.id, Payment.last))

      expected_json = %({
        "id": #{Payment.last.id},
        "paypal_payment_token": "ANY TOKEN"
      })

      expect(response.body).to be_json_eql(expected_json)
    end

    it "changes the state of the order to 'captured'" do
      post :create, order_id: order, paypal_payment_token: 'ANY TOKEN'

      captured_order = Order.find(order.id)

      expect(captured_order.captured?).to be true
    end
  end

end
