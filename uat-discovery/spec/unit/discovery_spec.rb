require 'spec_helper'

describe UAT::Discovery do
  it 'has a version number' do
    expect(UAT::Discovery::VERSION).not_to be nil
  end
end
