class AddStreetAndZipcodeAndCityToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :street, :string
    add_column :merchants, :zip_code, :string
    add_column :merchants, :city, :string
  end
end
