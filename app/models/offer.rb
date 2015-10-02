class Offer < ActiveRecord::Base

  has_one :image_gallery
  has_many :images, through: :image_gallery

end
