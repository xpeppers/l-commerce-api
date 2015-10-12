class Merchant < ActiveRecord::Base

  validates_presence_of :name, :telephone, :email, :web_site, :street, :zip_code, :city, :latitude, :longitude

end
