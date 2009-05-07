require 'rubygems'
require 'ruby_parser'
require 'facets'


module Roodi
  module Core
    class Parser
      def parse(content, filename)
        silence_stream(STDERR) do 
          return silent_parse(content, filename)
        end
      end
      
      private
      
      def silent_parse(content, filename)
        @parser ||= RubyParser.new
        @parser.parse(content, filename)
      end
    end
  end
end
