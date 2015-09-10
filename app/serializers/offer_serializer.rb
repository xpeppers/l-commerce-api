class OfferListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :original_price, :price, :image_url

  def price
    '%.2f' % object.price
  end

  def original_price
    '%.2f' % object.original_price unless object.original_price.nil?
  end
end

class OfferSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :image_url

  def price
    '%.2f' % object.price
  end
end
