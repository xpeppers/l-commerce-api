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
        redirect_to @merchant, notice: 'Merchant was successfully created.'
      else
        render :new
      end
    end

    def update
      if @merchant.update(merchant_params)
        redirect_to @merchant, notice: 'Merchant was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @merchant.destroy
      redirect_to merchants_url, notice: 'Merchant was successfully destroyed.'
    end

    private
      def set_merchant
        @merchant = Merchant.find(params[:id])
      end

      def merchant_params
        params[:merchant]
      end
  end
end
