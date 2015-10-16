module Api
  class SoldOffersController < AuthenticatedMerchantController

    def index
      render json: @authenticated_merchant.sold_offers, each_serializer: SoldOfferListSerializer
    end

  end
end
