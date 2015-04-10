module UAT
  module Consul
    # A consul client that uses Diplomat to get urls for a named service
    # @see [UAT::Consul::IClient]
    class Client < Interfaces::IClient
      # @param diplomat_service [Class<Diplomat::Service>] the diplomat service class reference
      # @param protocol [String] the protocol that should be prepended to urls_for_service
      # @param api [#new_uri] a factory method for creating new URIs
      # @param path_provider [UAT::Consul::Interfaces::IPathProvider] provides path for after host/port
      def initialize(diplomat_service, protocol, api, path_provider)
        @diplomat_service = diplomat_service
        @protocol = protocol
        @api = api
        @path_provider = path_provider
      end

      # @see [UAT::Consul::IClient]
      def urls_for_service(service_name)
        diplomat_services = @diplomat_service.get(service_name, :all)
        path = @path_provider.path_to_append_for(service_name)
        diplomat_services.map {|diplomat_service| @api.new_uri(uri_string(diplomat_service, path)) }
      end

      private

      def uri_string(diplomat_service, path)
        "#{@protocol}://#{diplomat_service.Address.to_s}:#{diplomat_service.ServicePort}#{path}"
      end
    end
  end
end