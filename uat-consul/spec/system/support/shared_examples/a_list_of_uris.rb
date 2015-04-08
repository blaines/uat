RSpec.shared_examples 'a list of URIs' do
  it { is_expected.to be_an_instance_of Array }
  it { is_expected.not_to be_empty }
  it 'each uri scheme matches the configured protocol' do
    subject.all? { |u| u.scheme == protocol }
  end
  it 'each uri path matches the configured append_service_path' do
    subject.all? { |u| u.path == append_service_path }
  end
end