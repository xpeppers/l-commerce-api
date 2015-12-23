class AddReservationPriceToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :reservation_price, :decimal, precision: 10, scale: 2
  end
end
