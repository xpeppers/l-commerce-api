class Merchant < ActiveRecord::Base
  include Authentication

  validates_presence_of :name, :telephone, :email, :hashed_password, :web_site, :street, :zip_code, :city, :latitude, :longitude

  def sold_offers
    BoughtOffer.joins(:merchant).where(merchants: {id: id})
  end

end
