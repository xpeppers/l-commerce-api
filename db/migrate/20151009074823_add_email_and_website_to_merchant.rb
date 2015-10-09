class AddEmailAndWebsiteToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :email, :string
    add_column :merchants, :website, :string
  end
end
