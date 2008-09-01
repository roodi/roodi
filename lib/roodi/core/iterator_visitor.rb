require 'java'
require 'roodi/core/tree_walker'

include_class 'org.jruby.ast.visitor.NodeVisitor'

module Roodi
  module Core
    class IteratorVisitor
      include TreeWalker

    	def initialize(payload)
      	@payload = payload
    	end
	
	  	def process_node(node)
    		node.accept(@payload)
      end      
    end
  end
end
