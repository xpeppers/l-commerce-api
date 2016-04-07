module GcmHelper

    def self.send_notification(offer)
        headers = {"Content-Type" => "application/json",
                   "Authorization" => GCM_CONFIG["authorization"]}

        url_string = GCM_CONFIG["url"]
        url = URI.parse( URI.encode(url_string) )
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        data = {:to => GCM_CONFIG["token"],
                :data => {"message" => {"id" => offer.id, "title" => offer.title} }}

        resp, dat = http.post(url.path, data.to_json, headers)

        return {:code => resp.code.to_i, :message => dat }

    end

end
