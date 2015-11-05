class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :title
      t.text :description
      t.references :image, index: true
      t.references :path, index: true
      t.references :merchant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
