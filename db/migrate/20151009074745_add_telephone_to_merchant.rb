class AddTelephoneToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :telephone, :string
  end
end
