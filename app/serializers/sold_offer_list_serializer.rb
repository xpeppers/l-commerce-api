class SoldOfferListSerializer < ActiveModel::Serializer
  attributes :id, :title, :buyer_email, :status, :purchase_date

  has_one :coupon

  def buyer_email
    object.user.email
  end
end
