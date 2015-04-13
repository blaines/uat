describe 'api.new_discovery_client.urls_for_service(service_name)' do
  include_context 'api setup'
  include_context 'dynamic setup'
  include_context 'real or mock discovery server based on environment'
  context 'when local_mode is configured false' do
    include_context 'dynamic setup'
    context 'and prefer_ips is configured true' do
      let(:prefer_ips) { true }
      context 'and discover_paths is configured false' do
        let(:config_hash) { dynamic_config_hash }
        let(:discover_paths) { false }
        it_behaves_like 'a list of URIs'
        it 'each URI.host is a valid IP address' do
          subject.all? { |u| IPAddress.valid? u.host }
        end
      end
      context 'and discover_paths is configured true' do
        include_context 'dynamic path discovery'
        it_behaves_like 'a list of URIs'
      end
    end
  end
end