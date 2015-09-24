module Api
  class PaymentsController < AuthenticatedUserController

    def create
      payment = Payment.new(payment_params)

      payment.capture!

      if not payment.captured?
        return render json: nil, status: :forbidden
      end

      if payment.save
        render json: payment, status: :created, location: api_order_payment_path(payment.order.id, payment.id)
      end
    end

    private

    def payment_params
      params.permit(:order_id, :paypal_payment_token)
    end

  end
end
