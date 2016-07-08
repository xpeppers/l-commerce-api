module Backoffice
  class OffersController < AuthenticatedController
    before_action :set_offer, only: [:show, :edit, :update, :destroy, :update_row_order]

    def index 
      @offers = Offer.order("row_order").all 
    end

    def new
      @offer = Offer.new
    end

    def create
      @offer = Offer.new(offer_params)
      @offer.row_order = 0

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


    def update_row_order 
      update_nex_row_order(@offer.row_order, order_params[:row_order].to_f)

      @offer.row_order = order_params[:row_order] 
      @offer.save 
      render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
    end 



    private 

    def update_nex_row_order(_from, _to)
      if _from != nil and _to != nil  
        while _from < _to
          offers = Offer.order("row_order").where("row_order > #{_from} and row_order <= #{_to}")
          offers.each do |offer|
            offer.row_order = _from
            offer.save
            _from += 1 
          end
        end  
        while _to < _from
          offers = Offer.order("row_order").where("row_order >= #{_to} and row_order < #{_from}")
          offers.each do |offer|
            _to += 1 
            offer.row_order = _to
            offer.save 
          end
        end  
      end
    end

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params 
      params.require(:offer).permit(:title, :description, :price, :original_price, :reservation_price, :merchant_id)
    end

    def order_params
      params.permit(:row_order)
    end

    def images
      params.require(:offer).permit(images: [])[:images] || []
    end
  end
end
