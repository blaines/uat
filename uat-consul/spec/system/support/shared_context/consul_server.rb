require 'json'
require 'webmock/rspec'

RSpec.shared_context 'real or mock consul server based on environment' do
  # let(:consul_server) { 'http://some-fake-consul-host:8500' }
  # let(:service_name) { 'some_service_name'}
  before(:each) do
    body_json =
    [
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
        # with(:headers => {'Accept'=>'*/*'}).
        to_return(:status => 200, :body => body_json.to_json, :headers => {})
  end
end