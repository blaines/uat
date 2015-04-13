require 'json'
require 'webmock/rspec'

RSpec.shared_context 'real or mock consul server based on environment' do
  before(:each) do
    setup_service_hosts_endpoint
    setup_key_value_endpoint
  end

  def setup_key_value_endpoint
    response = [
      {
        "CreateIndex" => 991,
        "ModifyIndex" => 11455806,
        "LockIndex" => 0,
        "Key" => "chef/services/#{service_name}",
        "Flags" => 0,
        "Value" => "eyJuYW1lIjoibG9va291dC1ibHVmZmRhbGUiLCJkZXBlbmRlbnRfc2VydmljZXMiOltdLCJoYXByb3h5X29wdGlvbnMiOnsicG9ydCI6NjAwOTF9LCJwb3J0cyI6eyJodHRwIjo4MDgwfSwiZW5kcG9pbnRfdGFncyI6WyJhY3RpdmUiXSwic2NoZW1hX3ZlcnNpb24iOiIwLjIiLCJtZXRhZGF0YSI6eyJyb290X3VybF9wYXRoIjoiL2JsdWZmZGFsZSJ9fQ=="
      }
    ]
    stub_request(:get, "#{consul_server}v1/kv/chef/services/#{service_name}").
        to_return(:status => 200, :body => response.to_json, :headers => {})
  end

  def setup_service_hosts_endpoint
    body_json = [
        {
            "Address" => "12.34.56.78",
            "ServicePort" => "5700",
            "Host" => "some-host-name"
        },
        {
            "Address" => "12.34.56.79",
            "ServicePort" => "2324",
            "Host" => "other-host-name"
        }
    ]
    stub_request(:get, "#{consul_server}v1/catalog/service/#{service_name}").
        to_return(:status => 200, :body => body_json.to_json, :headers => {})
  end
end