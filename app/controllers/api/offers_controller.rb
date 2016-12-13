module Api
  class OffersController < ApplicationController

    def index
      if params[:lat].nil? && params[:lon].nil?
        render json: Offer.order("created_at desc").all, each_serializer: OfferListSerializer
      else 
        merchant_ids = Merchant.by_distance(:origin => [46.076389,11.1190963]).select(:id).map(&:id)
        result = []
        for m in merchant_ids do
          for o in Offer.order("row_order").where(:merchant_id => m) do
            result << o
          end
        end
        render json: result, each_serializer: OfferListSerializer
      end
    end

    def show
      render json: Offer.find(params[:id])
    end

    def notify
        offer =  Offer.find(params[:offer_id])
        json_data = package_notification(GCM_CONFIG["token_global"], offer.title, params[:platform], offer.id)
        render json: NotificationHelper::notify(json_data)
    end

    def generic_notify
        puts "=== sending notification"
        json_data = package_notification(GCM_CONFIG["token_global"],  t(:general_notification_content), params[:platform], "generic")
        render json: NotificationHelper::notify(json_data)
    end


    private
    def package_notification(token, title, platform, offer_id)
        json_data = {}
        content = {}
        if offer_id == 'generic'
            content["generic"] = offer_id
        else
            content["id"] = offer_id
        end
        content["title"] = title


        if platform == "ios"
            json_data = {:ios => package_notification_ios(title, content)}
        elsif platform == "android"
            json_data = {:android => package_notification_android(token, content)}
        else
            json_data = {:ios => package_notification_ios(title, content),
                        :android => package_notification_android(token, content)}
        end
        return json_data
    end

    private
    def package_notification_ios(title, content)
        destinations = getDestinations()
        return {:destinations => destinations, :content => content}
    end

    private
    def package_notification_android(token, content)
        return {:token => token, :content => content}
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
