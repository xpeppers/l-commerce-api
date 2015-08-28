module Api
  class UsersController < ApplicationController
    def create
      user = User.create(user_params)
      render json: user, status: :created, location: api_user_path(user)
    end

    private

    def user_params
      params.permit(:email, :password)
    end
  end
end
