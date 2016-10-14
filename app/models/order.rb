class Order < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to :user
  has_many :bought_offers
  has_many :offers, through: :bought_offers
  has_one :coupon
  has_one :payment


  validate do |order|
    get_errors_from_offers(order.offers)
  end

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

  private

  def get_errors_from_offers(offers)
    offers.each do |offer|
      next if offer.valid?
      offer.errors.full_messages.each do |msg|
        errors.add(:offers, "#{offer.id}: #{msg}")
      end
    end
  end

end
