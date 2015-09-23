require 'rails_helper'

describe Api::PaymentsController, type: :controller do

  context 'with an authenticated user' do
    let(:user) { create(:user, token: 'ANY TOKEN') }
    let(:offer) { create(:offer) }
    let(:order) { create(:order, user: user, offers: [offer]) }

    before do
      expect(PaymentHelper).to receive(:capture_authorized_payment).with('GATEWAY PAYMENT ID').and_return(true)
      request.headers['Authorization'] = "Token token=#{user.token}"
    end

    describe 'POST #create' do
      it 'creates a new payment' do
        expect{
          post :create, order_id: order, paypal_payment_token: 'GATEWAY PAYMENT ID'
        }.to change(Payment, :count).by(1)
      end

      it 'responds with payment details' do
        post :create, order_id: order, paypal_payment_token: 'GATEWAY PAYMENT ID'

        expect(response).to have_http_status(:created)
        expect(response.header['Location']).to eq(api_order_payment_path(order.id, Payment.last))

        expected_json = %({
          "id": #{Payment.last.id},
          "paypal_payment_token": "GATEWAY PAYMENT ID"
        })

        expect(response.body).to be_json_eql(expected_json)
      end

      it "changes the state of the order to 'captured'" do
        post :create, order_id: order, paypal_payment_token: 'GATEWAY PAYMENT ID'

        order.reload

        expect(order).to be_captured
      end

      it "creates a coupon associated to order" do
        post :create, order_id: order, paypal_payment_token: 'GATEWAY PAYMENT ID'

        expect(order.coupon).not_to be_nil
      end
    end
  end

  context 'with an unauthenticated user' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer) }
    let(:order) { create(:order, user: user, offers: [offer]) }

    describe 'POST #create' do
      context 'without token' do
        it 'responds with unauthorized' do
          post :create, order_id: order, paypal_payment_token: 'GATEWAY PAYMENT ID'

          expect(response).to have_http_status(:unauthorized)
        end
      end

      describe 'with invalid token' do
        before do
          request.headers['Authorization'] = 'Token token=INVALID_TOKEN'
        end

        it 'responds with unauthorized' do
          post :create, order_id: order, paypal_payment_token: 'GATEWAY PAYMENT ID'

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

end
