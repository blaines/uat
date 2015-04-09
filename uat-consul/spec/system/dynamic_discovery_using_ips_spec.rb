describe 'api.new_consul_client.urls_for_service(service_name)' do
  include_context 'api setup'
  include_context 'dynamic setup'
  include_context 'real or mock consul server based on environment'
  context 'when local_mode is configured false' do
    include_context 'dynamic setup'
    context 'and prefer_ips is configured true' do
      let(:prefer_ips) { true }
      let(:config_hash) { dynamic_config_hash }
      it_behaves_like 'a list of URIs'
      it 'each URI.host is a valid IP address' do
        subject.all? { |u| IPAddress.valid? u.host }
      end
    end
  end
end