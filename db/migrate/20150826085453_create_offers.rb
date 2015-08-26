class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.string :image_url

      t.timestamps null: false
    end
  end
end
