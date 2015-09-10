class AddFieldsToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :original_price, :decimal, precision: 10, scale: 2
    add_column :offers, :merchant, :string
    add_column :offers, :telephone, :string
    add_column :offers, :email, :string
    add_column :offers, :web_site, :string
    add_column :offers, :street, :string
    add_column :offers, :zip_code, :string
    add_column :offers, :city, :string
    add_column :offers, :latitude, :string
    add_column :offers, :longitude, :string
  end
end
