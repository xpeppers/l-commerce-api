class AddImageToMerchants < ActiveRecord::Migration
  def change
    add_reference :merchants, :image, index: true, foreign_key: true
  end
end
