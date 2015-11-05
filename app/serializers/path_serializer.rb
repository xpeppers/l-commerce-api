class PathSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_url, :stages

  def stages
    []
  end

end
