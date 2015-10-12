class Offer < ActiveRecord::Base

  has_one :image_gallery
  belongs_to :merchant
  has_many :images, through: :image_gallery

  delegate :telephone, :email, :web_site, :street, :zip_code,
         :city, :latitude, :longitude,
         to: :merchant

  def image_url
    images.first.url if images.first.present?
  end

end
