require 'rubygems'
require 'parse_tree'

module Roodi
  module Core
    class Parser
      def parse(content, filename)
        @parser ||= ParseTree.new(true)
        node = @parser.parse_tree_for_string(content, filename)
        sexp = VisitableSexp.from_array node
        sexp.filename = filename
        sexp
      end
    end
  end
end
