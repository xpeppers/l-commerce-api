module Backoffice
  class ResellersController < AuthenticatedController
    before_action :set_reseller, only: [:show, :edit, :update]

    def update
      if @reseller.update(reseller_params)
        redirect_to backoffice_reseller_path, notice: 'Reseller was successfully updated.'
      else
        render :edit
      end
    end

    private

    def set_reseller
      @reseller = Reseller.last
    end

    def reseller_params
      params.require(:reseller).permit(:how_it_works, :support, :button_text, :custom_url)
    end

  end
end
