module OrderHelper
  def coupon_code_from(order)
    coupon = order.coupon
    coupon.present? ? coupon.code : ''
  end

  def merchant_name_from(order)
    offer = order.offers.last
    offer.present? ? offer.merchant.name : ''
  end

  def offer_title_from(order)
    offer = order.offers.last
    offer.present? ? offer.title : ''
  end
end