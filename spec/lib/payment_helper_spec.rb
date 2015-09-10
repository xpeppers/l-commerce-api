require 'rails_helper'
include PayPal::SDK

describe PaymentHelper, type: :lib do

  it 'captures an authorized paypal payment', integration: :paypal do
      result = PaymentHelper::capture_authorized_payment(paypal_payment_id)
      expect(result).to be true
  end
end

def paypal_payment_id
  payload = {
    :intent => "authorize",
    :payer => {
      :payment_method => "credit_card",
      :funding_instruments => [
        {
          :credit_card => {
            :type => "visa",
            :number => "4020027906955647",
            :expire_month => "07", :expire_year => "2020",
            :cvv2 => "598",
            :first_name => "JOE", :last_name => "FOO",
            :billing_address => {
              :line1 => "52 N Main ST",
              :city => "Johnstown",
              :state => "OH",
              :postal_code => "43210",
              :country_code => "US"
            }
          }
        }
      ]
    },
    :transactions => [
      {
        :amount => {
          :total => "7.47",
          :currency => "USD",
          :details => {
            :subtotal => "7.41",
            :tax => "0.03",
            :shipping => "0.03"
          }
        },
        :description => "This is the payment transaction description."
      }
    ]
  }

  payment = REST::Payment.new(payload)
  payment.create
  payment.id
end
