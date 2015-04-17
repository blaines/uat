module UAT
  module Matchers
    # DRY up protobuf RPC call expectations with RPCHelper
    class RPCHelper
      # @param rpc_service_url [URI::Generic]
      def initialize(rpc_service_url, rspec_example)
        @rpc_service_url = rpc_service_url
        @rspec_example = rspec_example
      end

      # @param rpc_class [#client] an rpc class with a client class method
      # @param method [Symbol] a symbol containing the method name to call
      # @param request [Protobuf::Message] the request object
      # @param response_class [Class<Protobuf::Message>] the expected response class
      # @yield block_that_receives_vetted_response an optional block which will be passed the response as long as it is an instance of the expected response_class
      # @yieldparam response [Protobuf::Message]
      # @yieldreturn is not used
      def make_rpc(rpc_class, method, request, response_class, &block_that_receives_vetted_response)
        opts = {:host => @rpc_service_url.host,
                :port => @rpc_service_url.port,
                :base => @rpc_service_url.path}
        rpc_class.client(opts).send(method, request) do |rpc_response_handler|
          rpc_response_handler.on_success do |response|
            @rspec_example.expect(response.class).to @rspec_example.be response_class
            block_that_receives_vetted_response.call(response) unless block_that_receives_vetted_response.nil?
          end
          rpc_response_handler.on_failure {|err| raise err.inspect }
        end
      end
    end
  end
end