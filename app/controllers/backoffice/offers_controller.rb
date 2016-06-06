module Backoffice
  class OffersController < AuthenticatedController
    before_action :set_offer, only: [:show, :edit, :update, :destroy]

    def index
      @offers = Offer.order("created_at desc").all
    end

    def new
      @offer = Offer.new
    end

    def create
      @offer = Offer.new(offer_params)

      @offer.create_image_gallery(image_ids: images) unless images.empty?

      if @offer.save
        redirect_to [:backoffice, @offer], notice: 'Offer was successfully created.'
      else
        flash[:error] = "Current price can not be greater than original price" unless @offer.valid?
        render :new
      end
    end

    def update
      if @offer.image_gallery.nil?
        @offer.create_image_gallery(image_ids: images) unless images.empty?
      else
        @offer.image_gallery.update(image_ids: images) unless images.empty?
      end

      if @offer.update(offer_params)
        redirect_to [:backoffice, @offer], notice: 'Offer was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @offer.update(active: false)
      redirect_to backoffice_offers_url, notice: 'Offer was successfully delete.'
    end

    private

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      puts params
      params.require(:offer).permit(:title, :description, :price, :original_price, :reservation_price, :merchant_id)
    end

    def images
      params.require(:offer).permit(images: [])[:images] || []
    end
  end
end
