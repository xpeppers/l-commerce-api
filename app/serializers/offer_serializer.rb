class OfferSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :image_url

  def price
    '%.2f' % object.price
  end
end
