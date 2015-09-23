module Api
  class AuthenticatedUserController < ApplicationController
    before_action :validate_user_authentication, only: [:index, :create, :show]

    private

    def validate_user_authentication
      return render json: nil, status: :unauthorized if authenticated_user.nil?
    end

    def authenticated_user
      authenticate_with_http_token do |token, options|
        @authenticated_user = User.find_by(token: token)
      end
    end

  end
end
