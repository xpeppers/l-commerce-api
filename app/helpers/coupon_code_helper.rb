module CouponCodeHelper
  def format_code(coupon)
    coupon.present? ? coupon.code : ''
  end
end