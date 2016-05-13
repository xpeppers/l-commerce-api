class User < ActiveRecord::Base
  include Authentication

  has_many :orders
  has_many :bought_offers, -> { joins(:payment).order(id: :asc) }, through: :orders

  validates_presence_of :email
  validates_presence_of :provider_user_id , :unless => :password?

  def fullname
    email
  end
end
