require 'rubygems'
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
        is_windows = !!(RbConfig::CONFIG['host_os'] =~ /mingw|mswin32|cygwin/)
        stream.reopen(is_windows ? 'NUL:' : '/dev/null')
        stream.sync = true
        yield
      ensure
        stream.reopen(old_stream)
      end
      
      def silent_parse(content, filename)
        @parser ||= RubyParser.new
        @parser.parse(content, filename)
      end
    end
  end
end
