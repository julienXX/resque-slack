require File.join(File.dirname(__FILE__) + '/../spec_helper')

class DummyJob
  extend Resque::Plugins::Slack

  def self.perform(*args); end
end
