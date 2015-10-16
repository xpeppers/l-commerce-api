module Api
  class AuthMerchantsController < ApplicationController

    before_action :set_merchant
    before_action :unauthorized?

    def create
      if @entity.authenticated?
        status = :ok
      else
        @entity.authenticate! TokenGenerator::generate
        status = :created
      end
      render json: @entity, status: status, serializer: AuthTokenSerializer
    end

    private

    def set_merchant
      @entity = Merchant.find_by(email: params[:email], hashed_password: params[:password])
    end

    def unauthorized?
      return head status: :unauthorized unless @entity.present?
    end
  end
end
