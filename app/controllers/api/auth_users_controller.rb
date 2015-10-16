module Api
  class AuthUsersController < FacebookAuthorizeController

    before_action :set_user
    before_action :unauthorized?

    def create
      if @user.authenticated?
        status = :ok
      else
        @user.authenticate! TokenGenerator::generate
        status = :created
      end
      render json: @user, status: status, serializer: AuthTokenSerializer
    end

    private

    def set_user
      @user = User.find_by(provider_user_id: @facebook_user_id)
    end

    def unauthorized?
      return head status: :unauthorized unless @user.present?
    end
  end
end
