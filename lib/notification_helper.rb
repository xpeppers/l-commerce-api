module NotificationHelper

    def self.notify_all(params)
        ios_data = params[:ios]
        android_data = params[:android]

        ios_result = sendToAPNS(ios_data[:destinations], ios_data[:message])
        android_result = sendToGCM(android_data[:token], android_data[:message])

        return { :android => android_result, :ios => ios_result }

    end

    def self.notify_ios(destinations, message)
        sendToAPNS(destinations, message)
    end

    def self.notify_android(token, message)
        sendToGCM(destinations, message) #{"id" => offer.id, "title" => offer.title}
    end
 


    private
    def self.sendToGCM(token, message)
        headers = {"Content-Type" => "application/json",
                   "Authorization" => GCM_CONFIG["authorization"]}

        url_string = GCM_CONFIG["url"]
        url = URI.parse( URI.encode(url_string) )
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        body = {:to => token,
                :data => {"message" => message }}

        resp_code, resp_data = http.post(url.path, body.to_json, headers)

        if resp_data != nil && resp_data.status != nil && resp_data.status != 200
            resp_code = "error"
        else
            resp_code = "success"
        end


        return {:status => resp_code, :message => resp_data }
    end

    private
    def self.sendToAPNS(destinations, message)
        app = RailsPushNotifications::APNSApp.new
        app.apns_dev_cert = File.read(File.join(Rails.root, 'config', APNS_CONFIG["certificate"]))
        app.apns_prod_cert = File.read(File.join(Rails.root, 'config', APNS_CONFIG["certificate"]))
        app.sandbox_mode = true

        resp_code = "error"
        resp_data = ""

        if app.save
          notif = app.notifications.build(
            destinations: destinations,
            data: { aps: { alert: message, sound: 'default', badge: 1 } }
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
