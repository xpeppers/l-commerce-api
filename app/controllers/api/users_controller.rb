module Api
  class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      user.provider_user_id = 'A Provider User Id'
      user.save
      render json: user, status: :created, location: api_user_path(user)
    end

    private

    def user_params
      params.permit(:email, :password)
    end
  end
end
