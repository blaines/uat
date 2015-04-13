module UAT
  module Discovery
    class ConsulPathProvider < Interfaces::IPathProvider
      # @param diplomat_service [Module<Diplomat>] the diplomat module
      # @param service_metadata_key_value_prefix [String] the key value prefix that comes before a service name
      # @param json_parser [JSON] native JSON module or compatible parser
      # @param metadata_property_for_path [String] the property on the metadata node containing the path
      def initialize(diplomat_module, service_metadata_key_value_prefix, json_parser, metadata_property_for_path)
        @diplomat_module = diplomat_module
        @service_metadata_key_value_prefix = service_metadata_key_value_prefix
        @json_parser = json_parser
        @metadata_property_for_path = metadata_property_for_path
      end

      # @param service_name [String] the name of the service for which one would like to get the path - ignored
      # @return [String]
      def path_to_append_for(service_name)
        #'chef/services/lookout-bluffdale'
        metadata = @diplomat_module.get("#{@service_metadata_key_value_prefix}#{service_name}")
        metadata_hash = @json_parser.parse(metadata)
        metadata_hash['metadata'][@metadata_property_for_path]
      end
    end
  end
end