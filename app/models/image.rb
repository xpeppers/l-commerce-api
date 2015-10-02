class Image < ActiveRecord::Base

  mount_uploader :resource, ImageUploader

  def url
    resource.url
  end

end
