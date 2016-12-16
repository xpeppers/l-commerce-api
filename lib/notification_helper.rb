module NotificationHelper

    def self.notify(params)
        
        result = {}
        
        if params[:ios]
            ios_data = params[:ios]
            ios_result = sendToAPNS(["94b121ccac212748142b7a031dde2222f0d40e437e709e06c8a3fe942d6687c2"], ios_data[:content])
            result[:ios] = ios_result
        end

        # if params[:android]
        #     android_data = params[:android]
        #     android_result = sendToGCM(android_data[:token], android_data[:content])
        #     result[:android] = android_result
        # end

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
        puts "================ sendToAPNS =======================" 
        start = Time.now
        if destinations.empty?
            return {:status => "success", :message => "Notification sent successfully" }
        end
        app = RailsPushNotifications::APNSApp.new
        app.apns_dev_cert = File.read(File.join(Rails.root, 'config', APNS_CONFIG["certificate"]))
        app.apns_prod_cert = File.read(File.join(Rails.root, 'config', APNS_CONFIG["certificate"]))
        app.sandbox_mode = false

        resp_code = "error"
        resp_data = "" 
        if app.save
            aps_data = { alert: content["title"], sound: 'default', badge: 1 }
            if content["generic"]
                aps_data["generic"] = content["generic"]
            else
                aps_data["id"] = content["id"]
            end
            puts "=== building notification"
            notif = app.notifications.build(
              destinations: destinations,
              data: { aps:  aps_data }
            )
            puts " ==== saving Notification"

            if notif.save
              puts "=== sending notification"
              
              app.push_notifications
              puts "== notification send, reloading..."
              notif.reload
              puts "=== notification SENT"
              puts notif.results
              resp_code = "success"
              resp_data = "Notification successfully pushed through!. Results #{notif.results.success} succeded, #{notif.results.failed} failed"

            else
              puts "notification error"
              puts notif.errors.full_messages
              resp_data = notif.errors.full_messages
            end
        else
            puts "APNS ERROR"
            puts app.errors.full_messages
            resp_data = app.errors.full_messages
        end

        puts Time.now - start
        puts "=======================================" 
        return {:status => resp_code, :message => resp_data }
    end

end
