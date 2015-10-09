class RenameWebsiteInMerchant < ActiveRecord::Migration
  def change
    rename_column :merchants, :website, :web_site
  end
end
