class BoughtOffer < ActiveRecord::Base
  belongs_to :order
  belongs_to :offer
  has_one :payment, through: :order

  delegate :description, :title, :image_url, to: :offer
end
