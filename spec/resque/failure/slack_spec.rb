require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe Resque::Plugins::Slack do
  it 'can be configurable' do
    expect(Resque::Plugins::Slack.config).to eq({})
  end
end
