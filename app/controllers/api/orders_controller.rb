module Api
  class OrdersController < ApplicationController
    def create
      order = Order.create
      render json: [], status: :created
    end
  end
end
