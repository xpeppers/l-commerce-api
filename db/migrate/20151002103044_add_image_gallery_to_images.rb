class AddImageGalleryToImages < ActiveRecord::Migration
  def change
    add_reference :images, :image_gallery, index: true, foreign_key: true
  end
end
