module UAT
  module Consul
    class Configuration
      # @param config_hash [Hash]
      def initialize(config_hash)
          @config_hash = config_hash
      end

      # @return [Hash<String, Array<String>>]
      def local_service_urls_keyed_by_service_name
        @config_hash['local_service_urls_keyed_by_service_name']
      end

      # @return [String]
      def local_mode?
        @config_hash['local_mode']
      end

      # @return [String]
      def protocol
        @config_hash['protocol']
      end

      # @return [String]
      def append_service_path
        @config_hash['append_service_path']
      end

      # @return [String]
      def url
        @config_hash['url']
      end
    end
  end
end