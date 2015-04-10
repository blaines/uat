describe 'api.new_consul_client.urls_for_service(service_name)' do
  context 'when local_mode is configured false' do
    include_context 'api setup'
    include_context 'dynamic setup'
    include_context 'real or mock consul server based on environment'
    context 'and prefer_ips is configured false' do
      let(:prefer_ips) { false }
      let(:format_host) { 'hostname.subdomain' }
      context 'and discover_paths is configured false' do
        let(:discover_paths) { false }
        let(:append_service_domain) { 'somedomain.net' }
        let(:config_hash) do
          {
              'append_service_domain' => append_service_domain,
          }.merge dynamic_config_hash
        end
        it_behaves_like 'a list of URIs'
        it 'each URI.host contains the configured append_service_domain' do
          subject.all? { |u| u.host.include? append_service_domain }
        end
      end
      context 'and discover_paths is configured true' do
        include_context 'dynamic path discovery'
        it_behaves_like 'a list of URIs'
      end
    end
  end
end