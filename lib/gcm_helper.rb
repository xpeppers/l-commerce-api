module GcmHelper

    def self.send_notification(offer)
        return sendToGCM({"id" => offer.id, "title" => offer.title})
    end


    def self.send_generic_notification(data)
        return sendToGCM(data)
    end


    private
    def self.sendToGCM(data)
        headers = {"Content-Type" => "application/json",
                   "Authorization" => GCM_CONFIG["authorization"]}

        url_string = GCM_CONFIG["url"]
        url = URI.parse( URI.encode(url_string) )
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        body = {:to => GCM_CONFIG["token"],
                :data => {"message" => data }}

        resp, dat = http.post(url.path, body.to_json, headers)

        return {:code => resp.code.to_i, :message => dat }
    end

end
