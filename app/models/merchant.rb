require 'bcrypt'

class Merchant < ActiveRecord::Base
  include BCrypt
  include Authentication

  validates_presence_of :name, :telephone, :email, :hashed_password, :web_site, :street, :zip_code, :city, :latitude, :longitude

  def password
    @password ||= Password.new(self.hashed_password) if self.hashed_password.present?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.hashed_password = @password
  end

  def sold_offers
    BoughtOffer.joins(:merchant).where(merchants: {id: id})
  end

end
