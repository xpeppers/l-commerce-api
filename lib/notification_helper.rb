module NotificationHelper

    def self.notify(params)

        result = {}

        if params[:ios]
            ios_data = params[:ios]
            ios_result = sendToAPNS(ios_data[:destinations], ios_data[:content])
            result[:ios] = ios_result
        end

        if params[:android]
            android_data = params[:android]
            android_result = sendToGCM(android_data[:token], android_data[:content])
            result[:android] = android_result
        end

        return result

    end




    private
    def self.sendToGCM(token, content)
        headers = {"Content-Type" => "application/json",
                   "Authorization" => GCM_CONFIG["authorization"]}

        url_string = GCM_CONFIG["url"]
        url = URI.parse( URI.encode(url_string) )
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        body = {:to => token,
                :data => {"message" => content }}

        resp_code, resp_data = http.post(url.path, body.to_json, headers)

        if resp_data != nil && resp_data.status != nil && resp_data.status != 200
            resp_code = "error"
        else
            resp_code = "success"
        end


        return {:status => resp_code, :message => resp_data }
    end

    private
    def self.sendToAPNS(destinations, content)
        app = RailsPushNotifications::APNSApp.new
        app.apns_dev_cert = File.read(File.join(Rails.root, 'config', APNS_CONFIG["certificate"]))
        app.apns_prod_cert = File.read(File.join(Rails.root, 'config', APNS_CONFIG["certificate"]))
        app.sandbox_mode = true

        resp_code = "error"
        resp_data = "" 
        if app.save
            aps_data = { alert: content["title"], sound: 'default', badge: 1 }
            if content["generic"]
                aps_data["generic"] = content["generic"]
            else
                aps_data["id"] = content["id"]
            end
          notif = app.notifications.build(
            destinations: destinations,
            data: { aps:  aps_data }
          )

          if notif.save
            app.push_notifications
            notif.reload

            resp_code = "success"
            resp_data = "Notification successfully pushed through!. Results #{notif.results.success} succeded, #{notif.results.failed} failed"

          else
            resp_data = notif.errors.full_messages
          end
        else
            resp_data = app.errors.full_messages
        end

        return {:status => resp_code, :message => resp_data }
    end

end