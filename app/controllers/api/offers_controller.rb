module Api
  class OffersController < ApplicationController

    def index
      render json: Offer.all, each_serializer: OfferListSerializer
    end

    def show
      render json: Offer.find(params[:id])
    end

    def notify
        json_data =  Offer.find(params[:offer_id])
        render json: GcmHelper::send_notification(json_data) 
    end


  end
end
