class RemoveTelephoneFromOffer < ActiveRecord::Migration
  def change
    remove_column :offers, :telephone, :string
  end
end
