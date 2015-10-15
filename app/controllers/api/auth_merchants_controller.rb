module Api
  class AuthMerchantsController < ApplicationController

    before_action :set_merchant
    before_action :unauthorized?

    def create
      if @merchant.authenticated?
        status = :ok
      else
        @merchant.authenticate! TokenGenerator::generate
        status = :created
      end
      render json: @merchant, status: status, serializer: AuthTokenSerializer
    end

    private

    def set_merchant
      @merchant = Merchant.find_by(email: params[:email], hashed_password: params[:password])
    end

    def unauthorized?
      return head status: :unauthorized unless @merchant.present?
    end
  end
end
