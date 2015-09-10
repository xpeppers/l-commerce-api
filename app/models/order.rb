class Order < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :offers
  has_one :coupon
  has_one :payment

  def pending?
    payment.nil?
  end

  def captured?
    payment.captured?
  end

  def generate_coupon!
    create_coupon(code: 'XXX')
  end

  def status
    return 'pending' if pending?
    return 'captured' if captured?
  end
end
