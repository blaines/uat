describe UAT::Discovery::MockClient do
  let(:existing_service_name) { 'existing_service_name' }
  let(:existing_service_url) { 'http://some-url.some-domain.com:4323' }
  let(:uri) { double :URI }
  let(:api) { double :TestAutomationAPI, :new_uri=>uri}
  let(:hash_of_service_urls_keyed_by_service_name) do
    {
      existing_service_name => [existing_service_url]
    }
  end

  subject { UAT::Discovery::MockClient.new hash_of_service_urls_keyed_by_service_name, api }
  describe '#new()' do
    it 'creates a new instance' do
      expect(subject).to be_a UAT::Discovery::MockClient
    end
  end

  describe '#urls_for_service(service_name)' do
    let(:urls_for_service) { subject.urls_for_service(service_name) }
    context 'when there is a service with the given name in the configuration' do
      let(:service_name) { existing_service_name }
      it 'provides the mocked out hosts' do
        expect(urls_for_service.first).to be uri
        expect(api).to have_received(:new_uri).with(existing_service_url)
      end
    end
    context 'when there is not a service with the given name in the configuration' do
      let(:service_name) { 'missing_service' }
      it 'raises an error' do
        expect{urls_for_service}.to raise_error
      end
    end
  end
end