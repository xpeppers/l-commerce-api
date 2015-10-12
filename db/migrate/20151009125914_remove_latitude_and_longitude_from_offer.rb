class RemoveLatitudeAndLongitudeFromOffer < ActiveRecord::Migration
  def change
    remove_column :offers, :latitude, :string
    remove_column :offers, :longitude, :string
  end
end
