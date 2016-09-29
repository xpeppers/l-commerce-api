class Order < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  validates :offer_ids, length: { minimum: 1 }

  belongs_to :user
  has_many :bought_offers
  has_many :offers, through: :bought_offers
  has_one :coupon
  has_one :payment

  def pending?
    payment.nil?
  end

  def captured?
    payment.captured?
  end

  def generate_coupon!
    create_coupon
  end

  def status
    return 'pending' if pending?
    return 'captured' if captured?
  end
end
