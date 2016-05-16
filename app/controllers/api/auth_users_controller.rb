module Api
  class AuthUsersController < ApplicationController

    include AuthorizeFacebookUser

    before_action :set_entity_via_facebook, only: [:create]
    before_action :set_entity_via_email_and_pass, only: [:email]
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

    def email
      render json: @entity
    end

    private

    def set_entity_via_facebook
      @entity = User.find_by(provider_user_id: @facebook_user_id)
    end

    def set_entity_via_email_and_pass
      @entity = User.find_by(email: params[:email], password: params[:password])
    end

    def handle_authorization?
      return head status: :unauthorized unless @entity.present?
    end
  end
end
