module UAT
  module Consul
    module Interfaces
      # @abstract
      class IClient
        # @abstract
        # @param service_name [String] the name of the service for which one would like to retrieve the host urls
        # @return [Array<URI::Generic>]
        def urls_for_service(service_name) raise NotImplementedError end
      end
    end
  end
end