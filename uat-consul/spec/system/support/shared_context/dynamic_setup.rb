RSpec.shared_context 'dynamic setup' do
  let(:local_mode) { false }
  let(:dynamic_config_hash) do
    {
        'protocol' => protocol,
        'prefer_ips' => prefer_ips,
        'append_service_path' => append_service_path
    }.merge root_config_hash
  end
  let(:protocol) { 'http' }
  let(:append_service_path) { '/somepath/goes/here' }
end