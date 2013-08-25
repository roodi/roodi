require 'ruby_parser'
require 'rbconfig'

module Roodi
  module Core
    class Parser
      def parse(content, filename)
        silence_stream(STDERR) do
          return silent_parse(content, filename)
        end
      end

      private

      def silence_stream(stream)
        old_stream = stream.dup
        stream.reopen(null_stream_output)
        stream.sync = true
        yield
      ensure
        stream.reopen(old_stream)
      end

      def silent_parse(content, filename)
        @parser ||= RubyParser.new
        @parser.parse(content, filename)
      end

      def null_stream_output
        null_output_for_platform(RbConfig::CONFIG['host_os'])
      end

      def null_output_for_platform(host_os)
        case host_os
        when windows_host_os_matcher
          'NUL:'
        else
          '/dev/null'
        end
      end

      def windows_host_os_matcher
        /mingw|mswin32|cygwin/o
      end
    end
  end
end
