class BoughtOffer < ActiveRecord::Base
  belongs_to :order
  belongs_to :offer

  has_one :user, through: :order
  has_one :payment, through: :order
  has_one :coupon, through: :order

  delegate :description, :title, :image_url, :images, :merchant, :street, :zip_code,
           :city, :latitude, :longitude, :telephone, :email, :web_site, :price,
           to: :offer

  def purchase_date
    payment.created_at.iso8601
  end
end
