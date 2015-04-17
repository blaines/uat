describe UAT::Matchers::RPCHelper do
  let(:url) { double :URL, :host=>'host',:port=>1234,:path=>'/base' }

  describe '#make_rpc(rpc_class, method, request, response_class, &optional_block)' do
    let(:rpc_client) { double :RPCClient }
    let(:method) { :some_method }
    let(:request) { double :RPCRequestInstance }
    let(:response_class) { double :ResponseClass }
    let(:rpc_class) { double :RPCClass, :client=>rpc_client }
    let(:callback) { double :callback, :on_success=>nil, :on_failure=>nil }
    let(:rspec_example) { double :RSpecExample }
    let(:optional_block) { nil }
    let(:send_rpc) { subject.make_rpc(rpc_class, method, request, response_class, &optional_block) }
    let(:expectation) { double :RSpecExpectation, :to=>nil }
    subject { described_class.new(url, rspec_example) }
    before(:each) do
      allow(rspec_example).to receive(:expect).and_return(expectation)
      allow(rspec_example).to receive(:be).and_return(nil)
      allow(rpc_client).to receive(:some_method).and_yield(callback)
    end
    shared_examples 'an rpc call' do
      before(:each) { send_rpc_behavior }
      it 'creates an instance of rpc_class using the "client" class method, passing a hash with the url parts' do
        expect(rpc_class).to have_received(:client).with(hash_including(:host=>url.host, :port=>url.port, :base=>url.path))
      end
      it 'calls the "method" on the resulting rpc_client, passing in the request' do
        expect(rpc_client).to have_received(:some_method).with(request)
      end
      it 'registers a callback for success' do
        expect(callback).to have_received(:on_success)
      end
      it 'registers a callback for failure' do
        expect(callback).to have_received(:on_failure)
      end
    end
    context 'when the request is successful' do
      let(:response) { double :Response , :class=>response_class }
      before(:each) do
        allow(callback).to receive(:on_success).and_yield(response)
      end
      it_behaves_like 'an rpc call' do
        let(:send_rpc_behavior) { send_rpc}
      end
      it 'performs an rspec expectation that the class of the response matches "response_class"' do
        send_rpc
        expect(response).to have_received(:class)
        expect(rspec_example).to have_received(:expect).with(response_class)
        expect(rspec_example).to have_received(:be).with(response_class)
      end
      context 'and if the rspec expectation fails' do
        before(:each) { allow(rspec_example).to receive(:be).and_raise }
        it 'raises an exception' do
          expect{send_rpc}.to raise_error
        end
      end
      context 'and if the rspec expectation passes' do
        before(:each) { send_rpc }
        context 'and a block is passed' do
          let(:in_test_callback) { double :in_test_callback, :call => nil }
          let(:optional_block) { in_test_callback.method(:call) }
          it 'calls the block, passing in the response' do
            expect(in_test_callback).to have_received(:call).with(response)
          end
        end
      end
    end
    context 'when the request is a failure' do
      let(:error_inspection_result) { double :Error }
      let(:response) { double :Error , :inspect=>error_inspection_result }
      before(:each) do
        allow(callback).to receive(:on_failure).and_yield(response)
      end
      it_behaves_like 'an rpc call' do
        let(:send_rpc_behavior) do
          begin
            send_rpc
          rescue => e
          end
        end
      end
      it 'raises an exception' do
        expect{send_rpc}.to raise_error
      end
    end
  end
end