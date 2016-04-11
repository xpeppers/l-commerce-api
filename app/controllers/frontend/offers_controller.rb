module Frontend
  class OffersController < ApplicationController

    before_action :set_offer, only: [:show]

    private

    def set_offer
      @offer = Offer.find(params[:id])
    end


  end
end
