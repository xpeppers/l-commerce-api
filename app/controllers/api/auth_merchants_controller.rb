module Api
  class AuthMerchantsController < ApplicationController

    before_action :set_entity
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

    def set_entity
      hashed_password = HashGenerator.generate(params[:password])
      @entity = Merchant.find_by(email: params[:email], hashed_password: hashed_password)
    end

    def unauthorized?
      return head status: :unauthorized unless @entity.present?
    end
  end
end
