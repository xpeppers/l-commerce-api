require 'rails_helper'

describe Api::OffersController, type: :controller do

  describe 'GET #index' do
    before do
      @first_offer = create :offer
      @second_offer = create :offer

      get :index
    end

    it { should respond_with(:success) }

    it 'should returns two offers' do
      expect(json).to contain_exactly(
                        to_hash(@first_offer),
                        to_hash(@second_offer)
                      )
    end
  end

  def to_hash(offer)
    {
      'id' => offer.id,
      'title' => offer.title,
      'description' => offer.description,
      'price' => offer.price.to_s,
      'image_url' => offer.image_url
    }
  end

end
