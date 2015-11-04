class RemoveImageFromMerchant < ActiveRecord::Migration
  def change
    remove_reference :merchants, :image, index: true, foreign_key: true
  end
end
