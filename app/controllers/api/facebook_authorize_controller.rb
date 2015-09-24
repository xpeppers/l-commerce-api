module Api
  class FacebookAuthorizeController < ApplicationController
    before_action :authorize_facebook_user, only: [:create]

    private

    def authorize_facebook_user
      @facebook_user_id = FacebookIdentity.user_id_from(params[:provider_token])

      render json: nil, status: :unauthorized if @facebook_user_id.nil?
    end
  end
end
