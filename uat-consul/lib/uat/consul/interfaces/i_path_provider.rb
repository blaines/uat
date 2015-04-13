module UAT
  module Consul
    module Interfaces
      # @abstract
      class IPathProvider
        # @abstract
        # @param service_name [String] the name of the service for which one would like to get the path
        # @return [String]
        def path_to_append_for(service_name) raise NotImplementedError end
      end
    end
  end
end