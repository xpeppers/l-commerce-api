class CreateTemporaryCodes < ActiveRecord::Migration
  def change
    create_table :temporary_codes do |t|
      t.integer :user_id
      t.string :code
      t.datetime :validity

      t.timestamps null: false
    end
  end
end
