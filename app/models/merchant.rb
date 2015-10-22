class Merchant < ActiveRecord::Base
  include Authentication

  validates_presence_of :name, :telephone, :email, :hashed_password, :web_site, :street, :zip_code, :city, :latitude, :longitude

  def password
    @password ||= Password.new(self.hashed_password) if self.hashed_password.present?
  end

  def password=(new_password)
    @password = HashGenerator.generate(new_password)
    self.hashed_password = @password
  end

  def sold_offers
    BoughtOffer.joins(:payment).joins(:merchant).where(merchants: {id: id})
  end

end
