RSpec.shared_context 'dynamic path discovery' do
  let(:config_hash) do
    {
        'service_metadata_key_value_prefix' => 'chef/services/',
        'metadata_property_for_path' => 'root_url_path'
    }.merge dynamic_config_hash
  end
  let(:discover_paths) { true }
end