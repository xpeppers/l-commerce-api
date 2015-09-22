module Api
  class AuthController < FacebookAuthorizeController

    def create
      user = User.find_by(provider_user_id: @facebook_user_id)
      user.token = 'API TOKEN'
      user.save

      render json: user, status: :created, serializer: UserTokenSerializer
    end

  end
end
