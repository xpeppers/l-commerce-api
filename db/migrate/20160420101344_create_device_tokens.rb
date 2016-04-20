class CreateDeviceTokens < ActiveRecord::Migration
  def change
    create_table :device_tokens do |t|
      t.string :token
      t.string :platform

      t.timestamps null: false
    end
  end
end
