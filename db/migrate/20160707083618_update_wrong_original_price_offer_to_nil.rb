class UpdateWrongOriginalPriceOfferToNil < ActiveRecord::Migration
  def change
    offers = Offer.all
    offers.each do |offer|
      if offer.original_price.present? && offer.price >= offer.original_price
        offer.original_price = nil
        offer.save
      end
    end
  end
end
