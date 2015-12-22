class CreateResellers < ActiveRecord::Migration
  def change
    create_table :resellers do |t|
      t.text :how_it_works
      t.text :support

      t.timestamps null: false
    end
  end
end
