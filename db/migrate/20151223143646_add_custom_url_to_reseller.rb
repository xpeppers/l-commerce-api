class AddCustomUrlToReseller < ActiveRecord::Migration
  def change
    add_column :resellers, :custom_url, :string
  end
end
