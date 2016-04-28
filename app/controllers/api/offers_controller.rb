module Api
  class OffersController < ApplicationController

    def index
      render json: Offer.all, each_serializer: OfferListSerializer
    end

    def show
      render json: Offer.find(params[:id])
    end

    def notify
        offer =  Offer.find(params[:offer_id])
        json_data = package_notification(GCM_CONFIG["token_global"], offer.title, params[:platform])
        render json: NotificationHelper::notify(json_data)
    end

    def generic_notify
        json_data = package_notification(GCM_CONFIG["token_global"],  t(:general_notification_content), params[:platform])
        render json: NotificationHelper::notify(json_data)
    end


    private
    def package_notification(token, title, platform)
        json_data = {}
        if platform == "ios"
            json_data = {:ios => package_notification_ios(title)}
        elsif platform == "android"
            json_data = {:android => package_notification_android(token, title)}
        else
            json_data = {:ios => package_notification_ios(title),
                        :android => package_notification_android(token, title)}
        end
        return json_data
    end

    private
    def package_notification_ios(title)
        destinations = getDestinations()
        return {:destinations => destinations, :message => title}
    end

    private
    def package_notification_android(token, title)
        return {:token => token, :message => title}
    end

    private
    def getDestinations()
        destinations = []
        devices = DeviceToken.all
        devices.each do |dv|
            destinations << dv.token
        end
        return destinations
    end
  end
end
