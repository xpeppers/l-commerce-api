class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status

  has_many :offers
end
