class BoughtOfferListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_url, :status
end
