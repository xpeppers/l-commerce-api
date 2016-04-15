class OfferListSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :original_price, :price, :reservation_price, :image_url, :latitude, :longitude, :url

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
    '%.2f' % object.reservation_price unless object.reservation_price.nil?
  end

  def original_price
    '%.2f' % object.original_price unless object.original_price.nil?
  end

  def url
      frontend_offer_url(object, host: Rails.configuration.asset_host)
  end
end
