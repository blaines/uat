module UAT
  module Consul
    class ConfiguredSinglePathProvider < Interfaces::IPathProvider
      # @param append_service_path [String] the path (if any) to append after the domain and port. Should include leading slash /
      def initialize(append_service_path)
        @append_service_path = append_service_path
      end

      # @param service_name [String] the name of the service for which one would like to get the path - ignored
      # @return [String]
      def path_to_append_for(service_name)
        @append_service_path
      end
    end
  end
end