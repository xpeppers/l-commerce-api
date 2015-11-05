class PathSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_url, :stages

  has_many :stages
end
