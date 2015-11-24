class AddSocialUrlsToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :facebook, :string
    add_column :merchants, :twitter, :string
  end
end
