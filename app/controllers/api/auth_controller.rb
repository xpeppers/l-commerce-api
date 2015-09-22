module Api
  class AuthController < FacebookAuthorizeController

    def create
      user = User.find_by(provider_user_id: @facebook_user_id)

      render json: nil, status: :created
    end

  end
end
