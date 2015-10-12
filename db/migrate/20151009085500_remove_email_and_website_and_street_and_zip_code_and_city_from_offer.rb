class RemoveEmailAndWebsiteAndStreetAndZipCodeAndCityFromOffer < ActiveRecord::Migration
  def change
    remove_column :offers, :email, :string
    remove_column :offers, :web_site, :string
    remove_column :offers, :street, :string
    remove_column :offers, :zip_code, :string
    remove_column :offers, :city, :string
  end
end
