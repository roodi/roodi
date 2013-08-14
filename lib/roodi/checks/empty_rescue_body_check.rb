require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks the body of a rescue block to make sure it's not empty..
    # 
    # When the body of a rescue block is empty, exceptions can get caught and swallowed without
    # any feedback to the user.
    class EmptyRescueBodyCheck < Check
      STATEMENT_NODES = [:fcall, :return, :attrasgn, :vcall, :nil, :call, :lasgn, :true, :false, :next]
      
      def interesting_nodes
        [:resbody]
      end

      def evaluate_start(node)
        add_error("Rescue block should not be empty.") unless has_statement?(node.children[1])
      end
  
      private
  
      def has_statement?(node)
        false unless node
        has_local_statement?(node) or node.children.any? { |child| has_statement?(child) } if node
      end

      def has_local_statement?(node)
        STATEMENT_NODES.include?(node.node_type)
      end
    end
  end
end
