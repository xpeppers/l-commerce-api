module Api
    class AppleController < ApplicationController
      def index
      end

      def create

        app = RailsPushNotifications::APNSApp.new
        app.apns_dev_cert = File.read(APNS_CONFIG["certificate"])
        app.apns_prod_cert = File.read(APNS_CONFIG["certificate"])
        app.sandbox_mode = true

        if app.save
          notif = app.notifications.build(
            destinations: [params[:destination]],
            data: { aps: { alert: params[:message], sound: 'default', badge: 1 } }
          )

          if notif.save
            app.push_notifications
            notif.reload
            render json: {:success => "Notification successfully pushed through!. Results #{notif.results.success} succeded, #{notif.results.failed} failed"}

          else
            render  json: { :message => notif.errors.full_messages }
          end
        else
          render json: { :message => app.errors.full_messages }
        end
      end
    end
end
