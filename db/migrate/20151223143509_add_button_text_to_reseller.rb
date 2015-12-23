class AddButtonTextToReseller < ActiveRecord::Migration
  def change
    add_column :resellers, :button_text, :string
  end
end
