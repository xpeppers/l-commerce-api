module GcmHelper

    def self.send_notification(offer)
        return sendToGCM(GCM_CONFIG["token_global"], {"id" => offer.id, "title" => offer.title})
    end


    def self.send_generic_notification( data)
        return sendToGCM(GCM_CONFIG["token_generic"], data)
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

end
