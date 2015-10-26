module Api
  class SoldOffersController < AuthenticatedMerchantController
    before_action :set_sold_offer, only: [:update]

    def index
      render json: @authenticated_merchant.sold_offers, each_serializer: SoldOfferListSerializer
    end

    def update
      @sold_offer.status = params[:status]
      @sold_offer.save

      render json: @sold_offer, serializer: SoldOfferStatusSerializer
    end

    private

    def set_sold_offer
      begin
        @sold_offer = BoughtOffer.find(params[:id])
      rescue
        return head :not_found
      end
    end
  end
end
