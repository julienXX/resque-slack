require 'resque'
require 'uri'
require 'net/http'

require 'resque/failure/notification'

module Resque
  module Failure
    class Slack < Base
      LEVELS = %i(verbose compact minimal)
      SLACK_URL = 'https://slack.com/api'

      class << self
        attr_accessor :channel # Slack channel id.
        attr_accessor :token   # Team token

        # Notification style:
        #
        # verbose: full backtrace (default)
        # compact: exception only
        # minimal: worker and payload
        attr_accessor :level

        def level
          @level && LEVELS.include?(@level) ? @level : :verbose
        end
      end

      # Configures the failure backend. You will need to set
      # a channel id and a team token.
      #
      # @example Configure your Slack account:
      #   Resque::Failure::Slack.configure do |config|
      #     config.channel = 'CHANNEL_ID'
      #     config.token = 'TOKEN'
      #     config.verbose = true or false, true is the default
      #   end
      def self.configure
        yield self
        fail 'Slack channel and token are not configured.' unless configured?
      end

      def self.configured?
        !!channel && !!token
      end

      # Sends the exception data to the Slack channel.
      #
      # When a job fails, a new instance is created and #save is called.
      def save
        return unless self.class.configured?

        report_exception
      end

      # Sends a HTTP Post to the Slack api.
      #
      def report_exception
        uri = URI.parse(SLACK_URL + '/chat.postMessage')
        params = { 'channel' => self.class.channel, 'token' => self.class.token, 'text' => text }
        Net::HTTP.post_form(uri, params)
      end

      # Text to be displayed in the Slack notification
      #
      def text
        Notification.generate(self, self.class.level)
      end
    end
  end
end

