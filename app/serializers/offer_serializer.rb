class OfferSerializer < OfferListSerializer
  attributes :merchant, :address, :telephone, :email, :web_site

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
