class Coupon < ActiveRecord::Base
  SEED = 786545
  MAX = 999999

  belongs_to :order

  def code
    num = (SEED + id) % MAX
    num.to_s
  end
end
