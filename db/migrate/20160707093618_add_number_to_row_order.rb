class AddNumberToRowOrder < ActiveRecord::Migration
  def change
    offers = Offer.all.order("created_at desc")
    i = 0
    offers.each do |offer|
      offer.row_order = i
      offer.save
      i += 1
    end
  end
end
