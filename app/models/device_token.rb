class DeviceToken < ActiveRecord::Base
    validates_presence_of :token
    validates_presence_of :platform
end
