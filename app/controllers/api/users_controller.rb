module Api
  class UsersController < ApplicationController
    before_action :authorize_facebook_user, only: [:create]
    before_action :user_already_exists, only: [:create]

    def create
      user = User.create(user_params.merge!(provider_user_id: @facebook_user_id))

      render json: user, status: :created, location: api_user_path(user)
    end

    private

    def user_params
      params.permit(:email)
    end

    def authorize_facebook_user
      @facebook_user_id = FacebookIdentity.user_id_from(params[:token])

      render json: nil, status: :unauthorized if @facebook_user_id.nil?
    end

    def user_already_exists
      user = User.find_by(provider_user_id: @facebook_user_id)

      render json: user, status: :ok, location: api_user_path(user) unless user.nil?
    end
  end
end
