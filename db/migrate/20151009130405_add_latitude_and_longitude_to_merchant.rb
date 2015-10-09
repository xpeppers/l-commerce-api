class AddLatitudeAndLongitudeToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :latitude, :float
    add_column :merchants, :longitude, :float
  end
end
