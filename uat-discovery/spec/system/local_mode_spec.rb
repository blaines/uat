describe 'api.new_discovery_client.urls_for_service(service_name)' do
  include_context 'api setup'
  context 'when local_mode is configured true' do
    let(:local_mode) { true }
    let(:local_service_url_1) { 'http://some-url.com:8080/some-path1' }
    let(:local_service_url_2) { 'http://some-url.com:8080/some-path2' }
    let(:config_hash) do
      {
          'local_service_urls_keyed_by_service_name' => {
              service_name => [
                  local_service_url_1,
                  local_service_url_2
              ]
          }
      }.merge root_config_hash
    end
    it { is_expected.to be_an_instance_of Array }
    it { is_expected.to include URI(local_service_url_1) }
    it { is_expected.to include URI(local_service_url_2) }
  end
end