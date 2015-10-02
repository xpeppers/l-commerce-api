class AddOfferToImageGalleries < ActiveRecord::Migration
  def change
    add_reference :image_galleries, :offer, index: true, foreign_key: true
  end
end
