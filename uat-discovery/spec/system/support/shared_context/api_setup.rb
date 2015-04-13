RSpec.shared_context 'api setup' do
  subject { discovery_client.urls_for_service(service_name) }
  let(:discovery_server) { 'http://some-host-name:8500/' }
  let(:configuration) { UAT::Discovery::Configuration.new config_hash }
  let(:api) {  UAT::Discovery::API.new(configuration) }
  let(:discovery_client) { api.new_client }
  let(:service_name) { 'some_server' }
  let(:root_config_hash) do
    {
        'url' => discovery_server,
        'local_mode' => local_mode
    }
  end
end