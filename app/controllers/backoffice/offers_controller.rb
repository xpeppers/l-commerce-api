module Backoffice
  class OffersController < AuthenticatedController
    before_action :set_offer, only: [:show, :edit, :update, :destroy]

    def index
      @offers = Offer.all
    end

    def new
      @offer = Offer.new
    end

    def create
      @offer = Offer.new(offer_params)

      if @offer.save
        redirect_to [:backoffice, @offer], notice: 'Offer was successfully created.'
      else
        render :new
      end
    end

    def update
      if @offer.update(offer_params)
        redirect_to [:backoffice, @offer], notice: 'Offer was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @offer.destroy
      redirect_to backoffice_offers_url, notice: 'Offer was successfully destroyed.'
    end

    private

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(:title, :description, :price, :original_price, :merchant, :telephone, :email, :web_site, :street, :zip_code, :city, :latitude, :longitude)
    end
  end
end
