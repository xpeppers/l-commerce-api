class Merchant < ActiveRecord::Base
  include Authentication

  before_destroy :has_stages?, :has_offers?

  belongs_to :image

  validates_presence_of :name, :description, :telephone, :email, :hashed_password, :street, :zip_code, :city, :latitude, :longitude
  validates :email, email_format: { message: "doesn't look like an email address" }

  def password
    @password = ''
    @password ||= Password.new(self.hashed_password) if self.hashed_password.present?
  end

  def password=(new_password)
    @password = HashGenerator.generate(new_password)
    self.hashed_password = @password if new_password.present?
  end

  def sold_offers
    BoughtOffer.joins(:payment).joins(:merchant).where(merchants: {id: id})
  end

  def image_url
    image.url if image.present?
  end

  def has_stages?
    Stage.where(merchant_id: id).empty?
  end

  def has_offers?
    Offer.where(merchant_id: id).empty?
  end

end
