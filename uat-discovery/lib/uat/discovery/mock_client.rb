module UAT
  module Discovery
    # A mock discovery client, mainly for use when running tests locally
    # Allows one to locally configure the hosts associated with a service name
    # @see [UAT::Discovery::IClient]
    class MockClient < Interfaces::IClient
      # @param hash_of_service_urls_keyed_by_service_name [Hash]
      # @param api [UAT::Discovery::API]
      def initialize(hash_of_service_urls_keyed_by_service_name, api)
        @hash_of_service_urls = hash_of_service_urls_keyed_by_service_name
        @api = api
      end

      # @see [UAT::Discovery::IClient#urls_for_service]
      def urls_for_service(service_name)
        if @hash_of_service_urls.has_key? service_name
          @hash_of_service_urls[service_name].map {|service_url| @api.new_uri(service_url)}
        else
          raise "URL for service #{service_name} could not be found"
        end
      end
    end
  end
end