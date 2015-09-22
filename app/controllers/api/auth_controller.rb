module Api
  class AuthController < FacebookAuthorizeController

    class << self
      def generate_token
        'API TOKEN'
      end
    end

    def create
      user = User.find_by(provider_user_id: @facebook_user_id)

      if user.authenticated?
        render json: nil, status: :ok
      else
        user.authenticate! AuthController::generate_token
        render json: user, status: :created, serializer: UserTokenSerializer
      end
    end

  end
end
