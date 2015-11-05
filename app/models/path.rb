class Path < ActiveRecord::Base
  belongs_to :image
  has_many :stages

  validates_presence_of :title, :description, :image

  def image_url
    image.url if image.present?
  end
end
