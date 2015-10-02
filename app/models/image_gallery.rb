class ImageGallery < ActiveRecord::Base

  has_many :images

  def add(image_asset)
    images.create(image_asset: image_asset)
  end

end
