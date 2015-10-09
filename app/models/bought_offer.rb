class BoughtOffer < ActiveRecord::Base
  belongs_to :order
  belongs_to :offer

  has_one :user, through: :order
  has_one :payment, through: :order
  has_one :coupon, through: :order
  has_one :merchant, through: :offer

  delegate :description, :title, :image_url, :images, :price,
           to: :offer

  delegate :telephone, :email, :web_site, :street, :zip_code, 
           :city, :latitude, :longitude, 
           to: :merchant

  def purchase_date
    payment.created_at.iso8601
  end
end
