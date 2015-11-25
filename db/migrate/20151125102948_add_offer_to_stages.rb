class AddOfferToStages < ActiveRecord::Migration
  def change
    add_reference :stages, :offer, index: true, foreign_key: true
  end
end
