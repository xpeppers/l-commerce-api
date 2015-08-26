module Api
  class OffersController < ApplicationController

    def index
      render json: Offer.all
    end

  end
end
