class AddMerchantToOffers < ActiveRecord::Migration
  def change
    add_reference :offers, :merchant, index: true, foreign_key: true
  end
end
