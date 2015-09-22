module Api
  class OrdersController < ApplicationController
    before_action :validate_user_authentication, only: [:create, :show]

    def create
      order = Order.create(order_params)
      render json: order, status: :created, location: api_order_path(order)
    end

    def show
      order = Order.find_by(id: params[:id])
      render json: order
    end

    private

    def validate_user_authentication
      return render json: nil, status: :unauthorized if authenticated_user.nil?
    end

    def authenticated_user
      authenticate_with_http_token do |token, options|
        User.find_by(token: token)
      end
    end

    def order_params
      params.permit(:user_id, :offer_ids => [])
    end
  end
end
