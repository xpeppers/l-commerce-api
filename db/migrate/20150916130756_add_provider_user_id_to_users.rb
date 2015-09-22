class AddProviderUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider_user_id, :string
  end
end
