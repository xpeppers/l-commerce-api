class Payment < ActiveRecord::Base
  belongs_to :order

  def capture!
    if PaymentHelper::capture_authorized_payment(paypal_payment_token)
      update_attributes(status: 'captured')
      order.generate_coupon!
    end
  end

  def captured?
    status.eql? 'captured'
  end
end
