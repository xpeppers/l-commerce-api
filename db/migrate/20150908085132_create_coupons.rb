class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
