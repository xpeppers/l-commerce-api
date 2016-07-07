class AddNumberToRowOrder < ActiveRecord::Migration
  def change
  	# Find all duplicate records and group them by a field
    offers = Offer.all.order("created_at desc")
    i = 0
    # Iterate on each grouped item to destroy duplicate
    offers.each do |offer|
      offer.row_order = i
      i += 1
      offer.save()
    end
  end
end
