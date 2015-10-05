class RemoveImageUrlFromOffers < ActiveRecord::Migration
  def change
    remove_column :offers, :image_url, :string
  end
end
