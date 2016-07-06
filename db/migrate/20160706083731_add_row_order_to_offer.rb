class AddRowOrderToOffer < ActiveRecord::Migration
  def change
  	add_column :offers, :row_order, :integer
  end
end
