class Payment < ActiveRecord::Base
  belongs_to :order

  def capture!
    if PaymentHelper::capture_authorized_payment(paypal_payment_token)
      update_attributes(status: 'captured')
      order.capture!
    end
  end

  def captured?
    status.eql? 'captured'
  end
end
