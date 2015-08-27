class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.references :user, index: true, foreign_key: true
    end

    create_table :offers_orders, id: false do |t|
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :offer, index: true, foreign_key: true
    end
  end
end
