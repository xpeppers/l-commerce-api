require 'rails_helper'

describe Api::OrdersController, type: :controller do

  describe 'POST #create' do
    before do
      @user = User.create
      @offer = Offer.create
    end

    it 'creates a new order' do
      expect{
        post :create, user: @user, offers: [@offer]
      }.to change(Order, :count).by(1)
    end

    it 'responds with order details' do
      post :create, user: @user, offers: [@offer]

      expect(response).to have_http_status(:created)
      expect(json).to eq({'id' => Offer.last.id, 'status' => 'pending'})
    end
  end

end
