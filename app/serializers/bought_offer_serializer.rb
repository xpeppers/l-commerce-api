class BoughtOfferSerializer < BoughtOfferListSerializer
  attributes :merchant, :address, :telephone, :email, :web_site, :price, :purchase_date

  has_one :coupon

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
