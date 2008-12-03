require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks the body of a rescue block to make sure it's not empty..
    # 
    # When the body of a rescue block is empty, exceptions can get caught and swallowed without
    # any feedback to the user.
    class EmptyRescueBodyCheck < Check
      STATEMENT_NODES = [:fcall, :return, :attrasgn]
      
      def interesting_nodes
        [:resbody]
      end

      def evaluate(node)
        add_error("Rescue block should not be empty.", 1) unless has_statement?(node)
      end
  
      private
  
      def has_statement?(node)
        found_statement = false
        found_statement = found_statement || STATEMENT_NODES.include?(node.node_type)
        found_statement = found_statement || assigning_other_than_exception_to_local_variable?(node) 
        node.children.each { |child| found_statement = found_statement || has_statement?(child) }
        found_statement
      end

      def assigning_other_than_exception_to_local_variable?(node)
        node.node_type == :lasgn && node[2].to_a != [:gvar, :$!]
      end
    end
  end
end
