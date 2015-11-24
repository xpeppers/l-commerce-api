class Merchant < ActiveRecord::Base
  include Authentication

  belongs_to :image

  validates_presence_of :name, :description, :telephone, :email, :hashed_password, :street, :zip_code, :city, :latitude, :longitude

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

  def image_url
    image.url if image.present?
  end
end
