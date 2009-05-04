require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks the body of a rescue block to make sure it's not empty..
    # 
    # When the body of a rescue block is empty, exceptions can get caught and swallowed without
    # any feedback to the user.
    class EmptyRescueBodyCheck < Check
      STATEMENT_NODES = [:fcall, :return, :attrasgn, :vcall, :nil]
      
      def interesting_nodes
        [:resbody]
      end

      def evaluate(node)
        add_error("Rescue block should not be empty.", 1) unless has_statement?(node)
      end
  
      private
  
      def has_statement?(node)
        return true if STATEMENT_NODES.include?(node.node_type)
        return true if assigning_other_than_exception_to_local_variable?(node) 
        return true if node.children.any? { |child| has_statement?(child) }
      end

      def assigning_other_than_exception_to_local_variable?(node)
        node.node_type == :lasgn && node[2].to_a != [:gvar, :$!]
      end
    end
  end
end
