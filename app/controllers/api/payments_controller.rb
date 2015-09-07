module Api
  class PaymentsController < ApplicationController

    def create
      payment = Payment.create(payment_params)
      render json: payment, status: :created, location: api_order_payment_path(payment.order.id, payment.id)
    end

    private

    def payment_params
      params.permit(:order_id, :paypal_payment_token)
    end

  end
end
