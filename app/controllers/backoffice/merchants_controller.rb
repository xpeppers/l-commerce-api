module Backoffice
  class MerchantsController < AuthenticatedController
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
      if @merchant.destroy
        redirect_to backoffice_merchants_url, notice: 'Merchant was successfully destroyed.'
      else
        redirect_to backoffice_merchants_url, alert: 'Impossible to delete merchant because it has offers or stages.'
      end
    end

    private

    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    def merchant_params
      params.require(:merchant).permit!
    end

  end
end
