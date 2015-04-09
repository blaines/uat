module UAT
  module Consul
    # A consul client that uses Diplomat to get urls for a named service
    # @see [UAT::Consul::IClient]
    class Client < Interfaces::IClient
      # @param diplomat_service [Class<Diplomat::Service>] the diplomat service class reference
      # @param protocol [String] the protocol that should be prepended to urls_for_service
      # @param api [#new_uri] a factory method for creating new URIs
      # @param append_service_path [String] the path (if any) to append after the domain and port. Should include leading slash /
      def initialize(diplomat_service, protocol, api, append_service_path)
        @diplomat_service = diplomat_service
        @protocol = protocol
        @api = api
        @append_service_path = append_service_path
      end

      # @see [UAT::Consul::IClient]
      def urls_for_service(service_name)
        diplomat_services = @diplomat_service.get(service_name, :all)
        diplomat_services.map {|diplomat_service| @api.new_uri(uri_string(diplomat_service)) }
      end

      private

      def uri_string(diplomat_service)
        "#{@protocol}://#{diplomat_service.Address.to_s}:#{diplomat_service.ServicePort}#{@append_service_path}"
      end
    end
  end
end