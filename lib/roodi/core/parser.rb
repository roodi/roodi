require 'rubygems'
require 'ruby_parser'

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
        stream.reopen(RUBY_PLATFORM =~ /mswin/ ? 'NUL:' : '/dev/null')
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
