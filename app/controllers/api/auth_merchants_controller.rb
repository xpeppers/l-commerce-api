module Api
  class AuthMerchantsController < ApplicationController

    def create
      merchant = Merchant.find_by(email: params[:email], hashed_password: params[:password])
      if merchant.present?
        merchant.authenticate! TokenGenerator::generate
        render json: merchant, status: :created, serializer: AuthTokenSerializer
      else
        head status: :unauthorized
      end
    end

  end
end
