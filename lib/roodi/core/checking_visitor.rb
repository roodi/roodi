module Roodi
  module Core
    class CheckingVisitor
      def initialize(*checks)
        @checks ||= {}
        checks.first.each do |check|
          nodes = check.interesting_nodes
          nodes.each do |node|
            @checks[node] ||= []
            @checks[node] << check
            @checks[node].uniq!
          end
        end
      end

    	def visit(node)
        checks = @checks[node.node_type]
        checks.each {|check| check.evaluate_node(node)} unless checks.nil?

    		visitable_nodes = node.is_language_node? ? node.sexp_body : node
    		visitable_nodes.each do |child| 
    		  if child.class == Sexp then
      		  child.accept(self)
    		  end
  		  end
    	end
    end
  end
end
