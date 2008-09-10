require 'rubygems'
require 'parse_tree'
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
        @parser ||= ParseTree.new(true)
        node = @parser.parse_tree_for_string(content, filename)
        sexp = VisitableSexp.from_array node
        sexp.filename = filename
        sexp
      end
    end
  end
end
