class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :paypal_payment_token
end
