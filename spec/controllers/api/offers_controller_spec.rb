require 'rails_helper'

describe Api::OffersController, type: :controller do

  describe 'GET #index' do
    before do
      @first_offer = create :offer
      @second_offer = create :offer

      get :index
    end

    it 'returns two offers' do
      expect(response).to have_http_status(:ok)

      expected_json = %([
        #{@first_offer.to_json(exept: [:created_at, :updated_at])},
        #{@second_offer.to_json(exept: [:created_at, :updated_at])}
      ])

      expect(response.body).to be_json_eql(expected_json)
    end
  end

end
