class Merchant < ActiveRecord::Base

  validates_presence_of :name, :telephone, :email, :hashed_password, :web_site, :street, :zip_code, :city, :latitude, :longitude

  validates :token, uniqueness: true, allow_nil: true

  def authenticate!(token)
    update_attributes(token: token)
  end

  def authenticated?
    not token.nil?
  end

  def sold_offers
    BoughtOffer.joins(:merchant).where(merchants: {id: id})
  end

end
