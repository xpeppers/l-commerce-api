module Api
  class OffersController < ApplicationController

    def index
      render json: Offer.all, each_serializer: OfferListSerializer
    end

    def show
      render json: Offer.find(params[:id])
    end

    def notify
    #     json_data =  Offer.find(params[:offer_id])
    #     render json: GcmHelper::send_notification(json_data)
    end
    
    def generic_notify

        json_data = {:ios => {:destinations => params["tokens"],
                              :message => t(:general_notification_content)},
                    :android => {:token => GCM_CONFIG["token_generic"],
                                 :message => t(:general_notification_content)}}

        render json: NotificationHelper::notify_all(json_data)
    end




  end
end
