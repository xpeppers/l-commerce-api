class AddPaypalPaymentTokenToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :paypal_payment_token, :string
  end
end
