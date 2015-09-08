module Api
  class OrdersController < ApplicationController
    def create
      order = Order.create(order_params)
      render json: order, status: :created, location: api_order_path(order)
    end

    def show
      order = Order.find_by(id: params[:id])
      render json: order
    end

    private

    def order_params
      params.permit(:user_id, :offer_ids => [])
    end
  end
end
