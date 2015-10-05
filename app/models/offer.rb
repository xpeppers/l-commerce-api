class Offer < ActiveRecord::Base

  has_one :image_gallery
  has_many :images, through: :image_gallery

  def image_url
    images.first.url if images.first.present?
  end

end
