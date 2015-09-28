class BoughtOfferSerializer < BoughtOfferListSerializer
  attributes :merchant, :address, :telephone, :email, :web_site, :price, :purchase_date, :user_fullname

  has_one :coupon

  def user_fullname
    object.user.fullname
  end

  def address
    {
      street: object.street,
      zip_code: object.zip_code,
      city: object.city,
      latitude: object.latitude,
      longitude: object.longitude
    }
  end
end
