class Merchant < ActiveRecord::Base

  validates_presence_of :name, :telephone, :email, :website, :street, :zip_code, :city

end
