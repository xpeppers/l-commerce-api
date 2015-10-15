module Api
  class AuthController < FacebookAuthorizeController

    def create
      user = User.find_by(provider_user_id: @facebook_user_id)

      if user.authenticated?
        render json: user, status: :ok, serializer: AuthTokenSerializer
      else
        user.authenticate! UserTokenGenerator::generate
        render json: user, status: :created, serializer: AuthTokenSerializer
      end
    end

  end
end
