module Backoffice
  class MerchantsController < ApplicationController
    before_action :set_merchant, only: [:show, :edit, :update, :destroy]

    def index
      @merchants = Merchant.all
    end

    def new
      @merchant = Merchant.new
    end

    def create
      @merchant = Merchant.new(merchant_params)

      if @merchant.save
        redirect_to [:backoffice, @merchant], notice: 'Merchant was successfully created.'
      else
        render :new
      end
    end

    def update
      if @merchant.update(merchant_params)
        redirect_to [:backoffice, @merchant], notice: 'Merchant was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @merchant.destroy
      redirect_to backoffice_merchants_url, notice: 'Merchant was successfully destroyed.'
    end

    private
      def set_merchant
        @merchant = Merchant.find(params[:id])
      end

      def merchant_params
        params.require(:merchant).permit(:name, :telephone, :email, :password, :web_site, :street, :zip_code, :city, :latitude, :longitude, :opening_hours, :description, :image_id)
      end

  end
end
