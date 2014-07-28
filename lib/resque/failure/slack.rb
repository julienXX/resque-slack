require 'resque'
require 'uri'
require 'net/http'

module Resque
  module Failure
    class Slack < Base
      Version = '0.1.0'

      class << self
        attr_accessor :channel # Slack channel id.
        attr_accessor :token   # Team token
      end

      # Configures the failure backend. You will need to set
      # a channel id and a team token.
      #
      # @example Configure your Slack account:
      #   Resque::Failure::Slack.configure do |config|
      #     config.channel = 'CHANNEL_ID'
      #     config.token = 'TOKEN'
      #   end
      def self.configure
        yield self
        fail 'Slack channel and token are not configured.' unless configured?
      end

      # Sends the exception data to the Slack channel.
      #
      # When a job fails, a new instance is created and #save is called.
      def save
        return unless configured?

        report_exception(*args)
      end

      def configured?
        !!channel && !!token
      end

      SLACK_URL = 'https://slack.com/api'

      def report_exception
        uri = URI.parse(SLACK_URL + '/chat.postMessage')
        params = { 'channel' => channel, 'token' => token, 'text' => text }
        Net::HTTP.post_form(uri, params)
      end

      def text
        <<-EOF
#{worker} failed processing #{queue}:
Payload:
#{payload.inspect.split("\n").map { |l| '  ' + l }.join('\n')}
Exception:
  #{exception}
#{exception.backtrace.map { |l| '  ' + l }.join('\n')}
        EOF
      end
    end
  end
end
