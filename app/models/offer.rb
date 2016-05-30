class Offer < ActiveRecord::Base

  default_scope { where(active: true) }

  before_destroy :bought?

  has_one :image_gallery, dependent: :destroy
  belongs_to :merchant
  has_many :images, through: :image_gallery

  validates_presence_of :merchant, :title, :description, :price, :reservation_price
  validate :price_must_be_less_than_original_price

  delegate :telephone, :email, :web_site, :facebook, :twitter, to: :merchant

  def image_url
    images.first.url if images.first.present?
  end

  def price_must_be_less_than_original_price
    errors.add(:price, "must be less than original_price") if original_price.present? && price > original_price
  end



  private

  def bought?
    BoughtOffer.where(offer_id: id).empty?
  end


end
