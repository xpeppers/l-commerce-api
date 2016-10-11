module Api
  class OrdersController < AuthenticatedUserController

    def create
      order = Order.new(order_params)
      if order.save
        render json: order, status: :created, location: api_order_path(order)
      else
        render json: order.errors, status: :unprocessable_entity
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
