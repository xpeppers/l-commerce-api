module Api
  class UsersController < ApplicationController
    def create
      provider_user_id = FacebookIdentity.user_id_from(token)
      if provider_user_id.nil?
        render json: nil, status: :unauthorized
      else
        user = User.new(user_params)
        user.provider_user_id = provider_user_id
        user.save
        render json: user, status: :created, location: api_user_path(user)
      end
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
