class Coupon < ActiveRecord::Base
  MIN = 100000
  MAX = 999999

  belongs_to :order

  def code
    random = Random.new(id)
    num = random.rand(MIN..MAX)
    num.to_s
  end
end
