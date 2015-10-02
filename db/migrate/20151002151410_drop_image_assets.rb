class DropImageAssets < ActiveRecord::Migration
  def change
    drop_table :image_assets
  end
end
