module PaymentHelper

  include PayPal::SDK

  def self.capture_authorized_payment(payment_id)
    payment = REST::Payment.find(payment_id)
    transaction = payment.transactions.first
    authorization = transaction.related_resources.first.authorization
    capture = authorization.capture(
      {
        :amount => {
          :currency => transaction.amount.currency,
          :total => transaction.amount.total
        },
        :is_final_capture => true
    })
    capture.success?
  end

end
