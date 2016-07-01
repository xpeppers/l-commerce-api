module Frontend
  class OffersController < ApplicationController

    before_action :set_offer, only: [:show]

    def index
      @offers = Offer.order("created_at desc").all
    end

    private

    def set_offer
      @offer = Offer.find(params[:id])
    end


  end
end
