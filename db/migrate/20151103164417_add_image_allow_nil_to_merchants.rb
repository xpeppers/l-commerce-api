class AddImageAllowNilToMerchants < ActiveRecord::Migration
  def change
    add_reference :merchants, :image, index: true
  end
end
