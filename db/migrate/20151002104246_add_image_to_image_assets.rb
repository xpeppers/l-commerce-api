class AddImageToImageAssets < ActiveRecord::Migration
  def change
    add_reference :image_assets, :image, index: true, foreign_key: true
  end
end
