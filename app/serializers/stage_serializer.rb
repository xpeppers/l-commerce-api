class StageSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_url, :merchant, :merchant_description, :merchant_image_url, :address,
             :telephone , :email , :web_site, :facebook, :twitter

  def merchant
    object.merchant.name
  end

  def merchant_image_url
    object.merchant.image_url
  end

  def merchant_description
    object.merchant.description
  end

  def telephone
    object.merchant.telephone
  end

  def email
    object.merchant.email
  end

  def web_site
    object.merchant.web_site
  end

  def facebook
    object.merchant.facebook
  end

  def twitter
    object.merchant.twitter
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
