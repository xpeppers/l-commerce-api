class UpdateDeviceTokenPk < ActiveRecord::Migration
  def change


    # Find all duplicate records and group them by a field
    dev_tokens =
       DeviceToken.group(:token)
          .having('count("token") > 1')
          .count(:token)

    # Iterate on each grouped item to destroy duplicate
    dev_tokens.each do |key, value|

      # Keep one and return rest of the duplicate records
      duplicates = DeviceToken.where(token: key)[1..value-1]
      puts "#{key} = #{duplicates.count}"

      # Destroy duplicates and their dependents
      duplicates.each(&:destroy)
    end


    add_index :device_tokens, [:token], :unique => true
  end
end
