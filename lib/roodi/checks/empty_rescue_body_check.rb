require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks the body of a rescue block to make sure it's not empty..
    # 
    # When the body of a rescue block is empty, exceptions can get caught and swallowed without
    # any feedback to the user.
    class EmptyRescueBodyCheck < Check
      STATEMENT_NODES = [:fcall, :return, :attrasgn, :vcall, :nil, :call]
      
      def interesting_nodes
        [:resbody]
      end

      def evaluate_start(node)
        add_error("Rescue block should not be empty.") unless has_statement?(node)
      end
  
      private
  
      def has_statement?(node)
        has_local_statement?(node) or node.children.any? { |child| has_statement?(child) }
      end

      def has_local_statement?(node)
        STATEMENT_NODES.include?(node.node_type) or assigning_other_than_exception_to_local_variable?(node) 
      end

      def assigning_other_than_exception_to_local_variable?(node)
        node.node_type == :lasgn && node[2].to_a != [:gvar, :$!]
      end
    end
  end
end
