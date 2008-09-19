require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks a method to make sure the number of parameters it has is under the specified limit.
    # 
    # A method taking too many parameters is a code smell that indicates it might be doing too 
    # much, or that the parameters should be grouped into one or more objects of their own.  It
    # probably needs some refactoring. 
    class AssignmentInConditionalCheck < Check
      def initialize(options = {})
        super()
      end
      
      def interesting_nodes
        [:if, :while]
      end

      def evaluate(node)
        add_error("Found = in conditional.  It should probably be an ==") if has_assignment?(node[1])
      end
      
      private
      
      def has_assignment?(node)
        found_assignment = false
        found_assignment = found_assignment || node.node_type == :lasgn
        node.children.each { |child| found_assignment = found_assignment || has_assignment?(child) }
        found_assignment
      end
    end
  end
end
