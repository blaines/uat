module UAT
  module Matchers
    class Configuration
      # @attr [String]
      attr_accessor :rpc_service_url

      # @attr [RSpec::Example] a reference to the current example to be used in the matcher
      attr_accessor :rspec_example
    end
  end
end