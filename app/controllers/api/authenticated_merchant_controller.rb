module Api
  class AuthenticatedMerchantController < ApplicationController
    before_action :validate_merchant_authentication, only: [:index, :create, :show, :update]

    private

    def validate_merchant_authentication
      return render json: nil, status: :unauthorized if authenticated_merchant.nil?
    end

    def authenticated_merchant
      authenticate_with_http_token do |token, options|
        @authenticated_merchant = Merchant.find_by(token: token)
      end
    end

  end
end
