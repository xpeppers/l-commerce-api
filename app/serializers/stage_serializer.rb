class StageSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_url, :merchant, :merchant_image_url, :address

  def merchant
    object.merchant.name
  end

  def merchant_image_url
    object.merchant.image_url
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
end

