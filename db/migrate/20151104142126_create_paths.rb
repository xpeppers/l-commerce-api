class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.string :title
      t.text :description
      t.references :image, index: true

      t.timestamps null: false
    end
  end
end
