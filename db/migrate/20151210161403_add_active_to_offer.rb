class AddActiveToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :active, :boolean, default: true
  end
end
