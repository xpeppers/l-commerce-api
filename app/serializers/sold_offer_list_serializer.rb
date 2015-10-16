class SoldOfferListSerializer < ActiveModel::Serializer
  attributes :id, :title, :buyer_email, :status

  has_one :coupon

  def buyer_email
    object.user.email
  end
end
