module Resque
  module Failure
    class Notification

      # Generate the text to be displayed in the Slack Notification
      #
      # failure: resque failure
      # level: notification style
      def self.generate(failure, level)
        new(failure, level).generate
      end

      def initialize(failure, level)
        @failure = failure
        @level   = level
      end

      def generate
        send(@level)
      end

      protected

      # Returns the worker & queue linked to the failed job
      #
      def msg_worker
        "#{@failure.worker} failed processing #{@failure.queue}"
      end

      # Returns the formatted payload linked to the failed job
      #
      def msg_payload
        "Payload:\n#{format_message(@failure.payload.inspect.split('\n'))}"
      end

      # Returns the formatted exception linked to the failed job
      #
      def msg_exception
        "Exception:\n#{exception}"
      end

      # Returns the formatted exception linked to the failed job with backtrace
      #
      def msg_exception_with_backtrace
        "#{msg_exception}\n#{format_message(exception.backtrace)}"
      end

      # Returns the verbose text notification
      #
      def verbose
        "#{msg_worker}\n#{msg_payload}\n#{msg_exception_with_backtrace}"
      end

      # Returns the compact text notification
      #
      def compact
        "#{msg_worker}\n#{msg_payload}\n#{msg_exception}"
      end

      # Returns the minimal text notification
      #
      def minimal
        "#{msg_worker}\n#{msg_payload}"
      end

      def format_message(obj)
        obj.map{ |l| "\t" + l }.join('\n')
      end

      def exception
        @failure.exception
      end
    end
  end
end

