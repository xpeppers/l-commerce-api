class OfferListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :original_price, :price, :reservation_price, :image_url, :latitude, :longitude

  def latitude
    object.merchant.latitude
  end

  def longitude
    object.merchant.longitude
  end

  def price
    '%.2f' % object.price
  end

  def reservation_price
    '%.2f' % object.reservation_price
  end

  def original_price
    '%.2f' % object.original_price unless object.original_price.nil?
  end
end
