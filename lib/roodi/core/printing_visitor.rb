require 'java'
require 'roodi/core/tree_walker'

module Roodi
  module Core
    class PrintingVisitor

      include TreeWalker
      
    	def initialize
      	@depth = 0
    	end
	
      def begin_children
        @depth = @depth + 1
      end
      
      def end_children
        @depth = @depth - 1
      end
      
    	def process_node(node)
    	  @depth.times { print '  ' }
    	  puts node
      end
      
    end 
	end
end
