module Api
  class AuthController < ApplicationController
    before_action :authorize_facebook_user, only: [:create]

    def create
      user = User.find_by(provider_user_id: @facebook_user_id)

      render json: nil, status: :created
    end

    private

    def authorize_facebook_user
      @facebook_user_id = FacebookIdentity.user_id_from(params[:provider_token])

      render json: nil, status: :unauthorized if @facebook_user_id.nil?
    end
  end
end
