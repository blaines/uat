module UAT
  module Matchers
    # DRY up protobuf RPC call expectations with RPCHelper
    module RPCHelper
      def self.setup!(rpc_service_url)
        @@rpc_service_url = rpc_service_url
      end

      # @param rpc_class [#client] an rpc class with a client class method
      # @param method [Symbol] a symbol containing the method name to call
      # @param request [Protobuf::Message] the request object
      # @param response_class [Class<Protobuf::Message>] the expected response class
      # @yield block_that_receives_vetted_response an optional block which will be passed the response as long as it is an instance of the expected response_class
      # @yieldparam response [Protobuf::Message]
      # @yieldreturn is not used
      def make_rpc(rpc_class, method, request, response_class, &block_that_receives_vetted_response)
        opts = {:host => @@rpc_service_url.host,
                :port => @@rpc_service_url.port,
                :base => @@rpc_service_url.path}
        rpc_class.client(opts).send(method, request) do |c|
          c.on_success do |response|
            expect(response.class).to be response_class
            block_that_receives_vetted_response.call(response) unless block_that_receives_vetted_response.nil?
          end
          c.on_failure {|err| raise err.inspect }
        end
      end
    end
  end
end