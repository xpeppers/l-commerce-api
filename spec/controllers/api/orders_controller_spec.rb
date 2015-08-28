require 'rails_helper'

describe Api::OrdersController, type: :controller do

  describe 'POST #create' do
    let(:user) { User.create }
    let(:offer) { Offer.create }

    it 'creates a new order' do
      expect{
        post :create, user: user, offers: [offer]
      }.to change(Order, :count).by(1)
    end

    it 'responds with order details' do
      post :create, user: user, offers: [offer]

      expect(response).to have_http_status(:created)

      expected_json = %({
        "id": #{Order.last.id},
        "status": "pending"
      })

      expect(response.body).to be_json_eql(expected_json)
    end
  end

end
