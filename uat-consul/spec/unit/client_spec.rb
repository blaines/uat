describe UAT::Consul::Client do
  let(:protocol) { double(:protocol).to_s }
  let(:diplomat_service) { double :DiplomatService, :get => diplomat_return_value }
  let(:append_service_path) { double(:append_service_path).to_s }
  let(:path_provider) { double :IPathProvider, :path_to_append_for => append_service_path }
  let(:host_name) { double(:host_name).to_s }
  let(:uri) { double :URI }
  let(:api) { double :TestAutomationAPI, :new_uri=>uri}
  subject { UAT::Consul::Client.new diplomat_service, protocol, api, path_provider }
  describe '#new(diplomat_service, domain_to_append_to_naked_consul_hosts)' do
    let(:diplomat_return_value) { [] }
    it 'creates a new instance' do
      expect(subject).to be_a UAT::Consul::Client
    end
  end

  describe '#urls_for_service(service_name)' do
    let(:service_name_in_consul) { double(:service_name_in_consul).to_s }
    let(:urls_for_service) { subject.urls_for_service(service_name_in_consul) }

    context 'when service is not found' do
      let(:diplomat_return_value) { [] }
      it 'returns an empty array' do
        expect(urls_for_service).to be_empty
      end
    end

    context 'when service is found' do
      let(:diplomat_service_1) { double :OpenStruct, :ServicePort => 1, :Address => host_name }
      let(:diplomat_service_2) { double :OpenStruct, :ServicePort => 2, :Address => host_name }
      let(:diplomat_return_value) { [ diplomat_service_1, diplomat_service_2] }

      it 'returns an array of urls' do
        expected_uri1 = "#{protocol}://#{host_name}:#{diplomat_service_1.ServicePort}#{append_service_path}"
        expected_uri2 = "#{protocol}://#{host_name}:#{diplomat_service_2.ServicePort}#{append_service_path}"

        expect(urls_for_service).to_not be_empty
        expect(api).to have_received(:new_uri).with(expected_uri1)
        expect(api).to have_received(:new_uri).with(expected_uri2)
      end
    end
  end
end