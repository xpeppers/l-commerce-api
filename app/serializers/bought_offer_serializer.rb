class BoughtOfferSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :merchant,
             :address, :telephone, :email, :web_site, :price,
             :purchase_date, :user_fullname, :image_gallery

  has_one :coupon

  def merchant
    object.merchant.name
  end

  def image_gallery
    object.images.map { |image| image.url }
  end

  def price
    '%.2f' % object.price
  end

  def user_fullname
    object.user.fullname
  end

  def address
    {
      street: object.street,
      zip_code: object.zip_code,
      city: object.city,
      latitude: object.merchant.latitude,
      longitude: object.merchant.longitude
    }
  end
end
