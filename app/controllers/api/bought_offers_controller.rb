module Api
  class BoughtOffersController < AuthenticatedUserController

    def index
      render json: @authenticated_user.bought_offers, each_serializer: BoughtOfferListSerializer
    end

    def show
      bought_offer = @authenticated_user.bought_offers.find_by(bought_offer_params)

      if bought_offer.nil?
        render json: nil, status: :not_found
      else
        render json: bought_offer
      end
    end

    private

    def bought_offer_params
      params.permit(:id)
    end
  end
end
