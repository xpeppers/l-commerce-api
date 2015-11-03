class AddOpeningHoursToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :opening_hours, :text
  end
end
