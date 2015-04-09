RSpec.shared_context 'api setup' do
  subject { consul_client.urls_for_service(service_name) }
  let(:consul_server) { 'http://some-host-name:8500/' }
  let(:configuration) { UAT::Consul::Configuration.new config_hash }
  let(:api) {  UAT::Consul::API.new(configuration) }
  let(:consul_client) { api.new_client }
  let(:service_name) { 'some_server' }
  let(:root_config_hash) do
    {
        'url' => consul_server,
        'local_mode' => local_mode
    }
  end
end