require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks a conditional to see if it contains an assignment.
    # 
    # A conditional containing an assignment is likely to be a mistyped equality check.  You
    # should either fix the typo or factor out the assignment so that the code is clearer.
    class AssignmentInConditionalCheck < Check

      def interesting_nodes
        [:if, :while]
      end

      def evaluate_start(node)
        add_error("Found = in conditional.  It should probably be an ==") if has_assignment?(node[1])
      end
      
      private
      
      def has_assignment?(node)
        found_assignment = false
        found_assignment = found_assignment || node.node_type == :lasgn
        if (node.node_type == :and or node.node_type == :or)
          node.children.each { |child| found_assignment = found_assignment || has_assignment?(child) }
        end
        found_assignment
      end

    end
  end
end
