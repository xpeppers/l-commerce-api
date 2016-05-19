module Api
  class AuthUsersController < ApplicationController

    include AuthorizeFacebookUser

    before_action :set_entity
    before_action :handle_authorization?


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
      if params[:provider] == "facebook"
        @entity = User.find_by(provider_user_id: @facebook_user_id)
      else
        @entity = User.find_by(email: params[:email], password: params[:provider_token])
      end
    end


    def handle_authorization?
      return head status: :unauthorized unless @entity.present?
    end
  end
end
