class BoughtOffer < ActiveRecord::Base
  belongs_to :order
  belongs_to :offer
end
