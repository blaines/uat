module UAT
  module Discovery
    # An instance of this API should be used to create all objects needed from this gem
    # The configuration with which it is instantiated controls all instances
    class API
      # @param configuration [UAT::Discovery::Configuration]
      def initialize(configuration)
        @configuration = configuration
      end

      # @return [UAT::Discovery::Interfaces::IClient] returns a client implementation based on configuration
      def new_client
        @configuration.local_mode? ? new_mock_client : new_real_client
      end

      # @return [UAT::Discovery::Client]
      def new_real_client
        Client.new(
            new_diplomat_service,
            @configuration.protocol,
            self,
            new_path_provider
        )
      end

      # @return [UAT::Discovery::MockClient]
      def new_mock_client
        MockClient.new(
            @configuration.local_service_urls_keyed_by_service_name,
            self
        )
      end

      # @param uri_string the uri string that should be converted to a URI object
      # @return [URI::Generic]
      def new_uri(uri_string)
        URI(uri_string)
      end

      private

      # @return [UAT::Discovery::Interfaces::IPathProvider]
      # @private
      def new_path_provider
        @configuration.discover_paths? ? new_discovery_path_provider : new_configured_path_provider
      end

      # @return [UAT::Discovery::ConsulPathProvider]
      # @private
      def new_discovery_path_provider
        ConsulPathProvider.new(
            Diplomat,
            @configuration.service_metadata_key_value_prefix,
            JSON,
            @configuration.metadata_property_for_path
        )
      end

      # @return [UAT::Discovery::ConfiguredSinglePathProvider]
      # @private
      def new_configured_path_provider
        ConfiguredSinglePathProvider.new(@configuration.append_service_path)
      end

      # @return [Diplomat::Service]
      # @private
      def new_diplomat_service
        configure_diplomat
        Diplomat::Service
      end

      # @return [Void] configures diplomat to use the configured discovery_url
      # @private
      def configure_diplomat
        Diplomat.configure do |config|
          config.url = @configuration.url
        end
      end
    end
  end
end