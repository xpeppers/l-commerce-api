module Api
  class OrdersController < AuthenticatedUserController

    def create
      order = Order.new(order_params)
      order.validate!
      puts "***order_params***", order_params.to_h
      puts "***order***", order
      puts "***order errors***", order.errors
      if order.save
        render json: order, status: :created, location: api_order_path(order)
      end
    end

    def show
      order = Order.find_by(id: params[:id], user: @authenticated_user)
      render json: order
    end

    private

    def order_params
      params.permit(:offer_ids => []).merge!(user: @authenticated_user)
    end
  end
end
