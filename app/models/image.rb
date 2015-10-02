class Image < ActiveRecord::Base

  has_one :image_asset

  def url
    "abc123"
  end

end
