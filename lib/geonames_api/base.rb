require 'uri'

module GeoNamesAPI
  class Base < Entity

    def self.find(*names_or_params)
      result = where(name_params(names_or_params))
      if result
        endpoint_returns_list? ? result.first : result
      end
    end

    def self.all(*names_or_params)
      result = where(name_params(names_or_params))
      if result
        endpoint_returns_list? ? result : [result]
      end
    end

    def self.where(params={})
      retries_remaining = GeoNamesAPI.retries
      uri = uri(params)
      begin
        response = make_request(uri)
        unless response.empty?
          parse_response(response, params)
        end
      rescue Timeout => e
        if retries_remaining > 0
          retries_remaining -= 1
          sleep_time = rand * GeoNamesAPI.max_sleep_time_between_retries
          GeoNamesAPI.logger.info("GEONAMES RETRIABLE ERROR: #{e}. Retrying in #{sleep_time}s.") if GeoNamesAPI.logger
          sleep sleep_time
          retry
        else
          raise e
        end
      end
    end

    def self.make_request(uri)
      JSON.load(open(uri, "User-Agent" => "#{GeoNamesAPI.name}/#{GeoNamesAPI::VERSION}").read)
    end

    private_class_method :make_request

    def self.parse_response(response, request_params)
      GeoNamesAPI.logger.info "GEONAMES RESPONSE (#{Time.now}): #{response}" if GeoNamesAPI.logger
      if (status = response['status'])
        raise Error.from_status(status)
      end
      new(response, request_params)
    end

    private_class_method :parse_response

    def self.uri(params={})
      endpoint = URI(GeoNamesAPI.url)
      endpoint.path = "/%s" % self::METHOD # URI.path requires a leading /
      endpoint.query = URI.encode_www_form(GeoNamesAPI.params.merge(params))
      GeoNamesAPI.logger.info "GEONAMES REQUEST (#{Time.now}): #{endpoint}" if GeoNamesAPI.logger
      endpoint
    end

    private_class_method :uri

    def self.name_params(names)
      return names.first if names.first.is_a? Hash
      params, n = {}, 0
      if names.any?
        [self::FIND_PARAMS].flatten.each { |i| params[i] = names[n]; n+= 1 }
      end
      params.delete_if { |k, v| v.blank? }
    end

    private_class_method :name_params

  end
end
