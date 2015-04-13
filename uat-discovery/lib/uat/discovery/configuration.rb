module UAT
  module Discovery
    class Configuration
      # @param config_hash [Hash]
      def initialize(config_hash)
          @config_hash = config_hash
      end

      # @return [Hash<String, Array<String>>]
      def local_service_urls_keyed_by_service_name
        @config_hash['local_service_urls_keyed_by_service_name']
      end

      # @return [Boolean]
      def local_mode?
        @config_hash['local_mode']
      end

      # @return [Boolean]
      def discover_paths?
        @config_hash['discover_paths']
      end

      # @return [String]
      def protocol
        @config_hash['protocol']
      end

      # @return [String] path that will be appended to discovery host/port, no matter what service name
      def append_service_path
        @config_hash['append_service_path']
      end

      # @return [String] the prefix to prepend to a service name, used to retrieve discovery key value requests for a service
      def service_metadata_key_value_prefix
        @config_hash['service_metadata_key_value_prefix']
      end

      # @return [String] the property name in discovery key/value metadata hash containing a service's path
      def metadata_property_for_path
        @config_hash['metadata_property_for_path']
      end

      # @return [String]
      def url
        @config_hash['url']
      end
    end
  end
end