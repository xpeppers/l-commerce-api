module Api
  class ResellersController < ApplicationController

    def show
      render json: Reseller.first
    end

  end
end
