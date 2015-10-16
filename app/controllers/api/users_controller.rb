module Api
  class UsersController < ApplicationController

    include AuthorizeFacebookUser

    before_action :user_already_exists, only: [:create]

    def create
      user = User.create(user_params.merge!(provider_user_id: @facebook_user_id))

      render json: user, status: :created, location: api_user_path(user)
    end

    private

    def user_params
      params.permit(:email)
    end

    def user_already_exists
      user = User.find_by(provider_user_id: @facebook_user_id)

      render json: user, status: :ok, location: api_user_path(user) unless user.nil?
    end
  end
end
