require 'rubygems'
require 'sexp'

module Roodi
  module Core
    class VisitableSexp < Sexp
      def accept(visitor)
        visitor.visit(self)
      end
      
      def node_type
        first
      end
      
      def children
        sexp_body.select {|each| each.class == VisitableSexp }
      end
      
      def is_language_node?
        first.class == Symbol
      end
      
      def filename=(filename)
        @filename = filename
      end
      
      def filename
        @filename
      end
    end
  end
end
