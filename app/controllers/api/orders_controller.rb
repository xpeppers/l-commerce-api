module Api
  class OrdersController < ApplicationController
    def create
      order = Order.create
      render json: order, status: :created
    end
  end
end
