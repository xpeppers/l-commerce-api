class AddPasswordToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :hashed_password, :string
  end
end
