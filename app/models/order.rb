class Order < ActiveRecord::Base
  after_initialize :set_default_status

  belongs_to :user
  has_and_belongs_to_many :offers
  has_one :coupon
  has_one :payment

  def pending?
    payment.nil?
  end

  def captured?
    self.status.eql? 'captured'
  end

  def capture!
    build_coupon(code: 'XXX')
    update_attributes(status: 'captured')
  end

  private

  def set_default_status
    self.status ||= 'pending'
  end
end
