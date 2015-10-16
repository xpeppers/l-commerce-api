module Api
  class AuthUsersController < ApplicationController

    include AuthorizeFacebookUser

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
      @entity = User.find_by(provider_user_id: @facebook_user_id)
    end

    def unauthorized?
      return head status: :unauthorized unless @entity.present?
    end
  end
end
