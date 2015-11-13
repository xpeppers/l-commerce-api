class OfferSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :original_price, :price, :image_gallery,
             :merchant, :address, :telephone, :email, :web_site

  def merchant
    object.merchant.name
  end

  def image_gallery
    object.images.map { |image| image.url }
  end

  def address
    {
      street: object.merchant.street,
      zip_code: object.merchant.zip_code,
      city: object.merchant.city,
      latitude: object.merchant.latitude,
      longitude: object.merchant.longitude
    }
  end

  def price
    '%.2f' % object.price
  end

  def original_price
    '%.2f' % object.original_price unless object.original_price.nil?
  end
end
