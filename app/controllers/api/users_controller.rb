module Api
  class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      user.provider_user_id = FacebookIdentity.user_id_from(token)
      user.save
      render json: user, status: :created, location: api_user_path(user)
    end

    private

    def user_params
      params.permit(:email)
    end

    def token
      params[:token]
    end
  end
end
