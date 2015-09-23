class BoughtOffer < ActiveRecord::Base
  belongs_to :order
  belongs_to :offer

  delegate :id, :description, :title, :image_url, to: :offer
end
