class Image < ActiveRecord::Base

  mount_uploader :resource, ImageUploader

  def url
    ActionController::Base.helpers.asset_url(resource.url)
  end

end
