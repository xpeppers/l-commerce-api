class CreateBoughtOffers < ActiveRecord::Migration
  def change
    create_table :bought_offers do |t|
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :offer, index: true, foreign_key: true
      t.string :status, default: 'unused'
    end

    drop_table :offers_orders
  end
end
