class RemoveCodeFromCoupon < ActiveRecord::Migration
  def change
    remove_column :coupons, :code, :string
  end
end
