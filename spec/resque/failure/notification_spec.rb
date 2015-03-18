require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe Resque::Failure::Notification do

  Resque::Failure::Slack::LEVELS.each do |level|
    context "level #{level}" do
      it 'returns the wanted format text' do
        notification = described_class.generate(failure, level)
        expect(notification).to eq expected_notification[level]
      end

      def expected_notification
        {
          verbose: "worker failed processing queue\nPayload:\n\t\"payload\"\nException:\nexception\n\tbacktrace",
          compact: "worker failed processing queue\nPayload:\n\t\"payload\"\nException:\nexception",
          minimal: "worker failed processing queue\nPayload:\n\t\"payload\""
        }
      end
    end
  end

  def failure
    exception = double('exception', to_s: 'exception', backtrace: ['backtrace'])
    Resque::Failure::Slack.new(exception, 'worker', 'queue', 'payload')
  end

end

