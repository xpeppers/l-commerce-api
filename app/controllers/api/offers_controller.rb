module Api
  class OffersController < ApplicationController

    def index
      render json: Offer.all, each_serializer: OfferListSerializer
    end

    def show
      render json: Offer.find(params[:id])
    end

  end
end
