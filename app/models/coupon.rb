class Coupon < ActiveRecord::Base
  MIN = 100000
  MAX = 999999

  belongs_to :order

  after_create :set_code

  private

  def set_code
    random = Random.new(id)
    num = random.rand(MIN..MAX)
    self.update(code: num.to_s)
  end
end
