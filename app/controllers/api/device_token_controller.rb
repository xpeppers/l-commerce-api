module Api
  class DeviceTokenController < ApplicationController

    def index
      render json: DeviceToken.all
    end

    def create
      device_token = DeviceToken.new(device_params)
      if device_token.save
          render json: device_token, status: :created
      end
    end


    def device_params
       params.permit(:token, :platform)
    end


  end
end
