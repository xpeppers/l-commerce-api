class Offer < ActiveRecord::Base

  has_one :image_gallery
  belongs_to :merchant
  has_many :images, through: :image_gallery

  validates_presence_of :merchant, :title, :description, :price

  delegate :telephone, :email, :web_site, to: :merchant

  def image_url
    images.first.url if images.first.present?
  end

end
