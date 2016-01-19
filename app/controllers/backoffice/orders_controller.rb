module Backoffice
  class OrdersController < AuthenticatedController
    before_action :set_order, only: [:show]

    def index
      @orders = Order.all
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
