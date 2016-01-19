module Backoffice
  class OrdersController < AuthenticatedController

    def index
      @orders = Order.all
    end

  end
end
