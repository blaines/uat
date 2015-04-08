module UAT
  module Consul
    # An instance of this API should be used to create all objects needed from this gem
    # The configuration with which it is instantiated controls all instances
    class API
      # @param configuration [UAT::Consul::Configuration]
      def initialize(configuration)
        @configuration = configuration
      end

      # @return [UAT::Consul::Interfaces::IClient] returns a client implementation based on configuration
      def new_client
        @configuration.local_mode? ? new_mock_client : new_real_client
      end

      # @return [Diplomat::Service]
      # @private
      def new_diplomat_service
        configure_diplomat
        Diplomat::Service
      end

      # @return [Void] configures diplomat to use the configured consul_url
      # @private
      def configure_diplomat
        Diplomat.configure do |config|
          config.url = @configuration.url
        end
      end

      # @return [UAT::Consul::Client]
      # @private
      def new_real_client
        Client.new(
            new_diplomat_service,
            @configuration.protocol,
            self,
            @configuration.append_service_path,
        )
      end

      # @return [UAT::Consul::MockClient]
      # @private
      def new_mock_client
        MockClient.new(
            @configuration.local_service_urls_keyed_by_service_name,
            self
        )
      end

      # @param uri_string the uri string that should be converted to a URI object
      # @return [URI::Generic]
      # @private
      def new_uri(uri_string)
        URI(uri_string)
      end
    end
  end
end