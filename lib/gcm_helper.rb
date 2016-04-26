module GcmHelper

    def self.send_notification(offer)
        return sendToGCM(GCM_CONFIG["token_global"], {"id" => offer.id, "title" => offer.title})
    end


    def self.send_generic_notification( data, device_tokens=[])
        response = {:gcm => sendToGCM(GCM_CONFIG["token_generic"], data),
                    :apns => sendToAPNS(device_tokens, data)}
        return
    end


    private
    def self.sendToGCM(token, data)
        headers = {"Content-Type" => "application/json",
                   "Authorization" => GCM_CONFIG["authorization"]}

        url_string = GCM_CONFIG["url"]
        url = URI.parse( URI.encode(url_string) )
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        body = {:to => token,
                :data => {"message" => data }}

        resp_code, resp_data = http.post(url.path, body.to_json, headers)

        if resp_data != nil && resp_data.status != nil && resp_data.status != 200
            resp_code = "error"
        else
            resp_code = "success"
        end


        return {:code => resp_code, :message => resp_data }
    end

    private
    def self.sendToAPNS(device_tokens, data)
        app = RailsPushNotifications::APNSApp.new
        app.apns_dev_cert = File.read(APNS_CONFIG["certificate"])
        app.apns_prod_cert = File.read(APNS_CONFIG["certificate"])
        app.sandbox_mode = true

        if app.save
          notif = app.notifications.build(
            destinations: device_tokens,
            data: { aps: { alert: data, sound: 'default', badge: 1 } }
          )

          if notif.save
            app.push_notifications
            notif.reload
            render json: {:code => "success", :message => "Notification successfully pushed through!. Results #{notif.results.success} succeded, #{notif.results.failed} failed"}

          else
            render  json: {:code => "error", :message => notif.errors.full_messages }
          end
        else
          render json: {:code => "error", :message => app.errors.full_messages }
        end
      end

end
