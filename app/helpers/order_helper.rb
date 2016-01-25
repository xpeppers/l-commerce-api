module OrderHelper
  def coupon_code_from(order)
    coupon = order.coupon
    coupon.present? ? coupon.code : ''
  end

  def coupon_status_from(order)
    coupon = order.coupon
    bought_offers = order.bought_offers.last
    status = bought_offers.present? ? bought_offers.status : ''
    coupon.present? ? status : ''
  end

  def merchant_name_from(order)
    offer = order.offers.last
    offer.present? ? offer.merchant.name : ''
  end

  def offer_title_from(order)
    offer = order.offers.last
    offer.present? ? offer.title : ''
  end

  def timestamp_from(order)
    timestamp = order.created_at
    timestamp.present? ? timestamp.in_time_zone('Rome') : ''
  end
end