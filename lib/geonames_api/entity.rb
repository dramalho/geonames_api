require 'forwardable'

module GeoNamesAPI
  class Entity
    include Enumerable
    extend Forwardable
    def_delegator :geonames, :each
    alias_method :size, :count
    attr_reader :request_params

    def initialize(response, request_params = nil)
      marshal_load([response, request_params])
    end

    def marshal_load(x)
      @response, @request_params = x
      parse_response
    end

    def marshal_dump
      [@response, @request_params]
    end

    def parse_response
      @response.keys.each { |ea| parse_attr(ea) }
    end

    def parse_attr(key)
      return unless @response.has_key? key

      aliases = []
      value = @response[key]
      parsed_value = case (key)
        when 'geonames', 'streetSegment', 'postalcodes'
          aliases = [:geonames, :results, :postalcodes]
          value.map { |ea| self.class.new(ea) }
        when 'alternateNames'
          AlternateNames.new(value)
        when 'timezone'
          TimeZone.new(value)
        else
          set_default_type(value)
      end

      attr_name = create_attribute(key, *aliases)
      instance_variable_set(attr_name, parsed_value)
    end

    def create_attribute(attribute, *attribute_aliases)
      attr_name = attribute.underscore.to_sym
      self.class.send(:attr_reader, attr_name) unless respond_to?(attr_name)

      attribute_aliases.each do |ea|
        self.class.send(:alias_method, ea, attr_name) unless respond_to?(ea)
      end

      "@#{attr_name}".to_sym
    end

    def set_default_type(value)
      case value
        when /\A-?\d+\Z/
          value.to_i
        when /\A-?\d*\.\d*\Z/
          value.to_f
        else
          value
      end
    end
  end
end
