module UAT
  module Matchers
    class API
      # @param configuration [UAT::Matchers::Configuration]
      def initialize(configuration)
        @configuration = configuration
      end

      # @return [UAT::Matchers::RPCHelper]
      def rpc_helper
        RPCHelper.new(@configuration.rpc_service_url, @configuration.rspec_example)
      end
    end
  end
end