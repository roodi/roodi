require 'roodi/checks/check'

module Roodi
  module Checks
    class EmptyRescueBodyCheck < Check
      def interesting_nodes
        [:resbody]
      end

      def evaluate(node)
        add_error "#{position(node)} - Rescue block should not be empty." unless has_statement?(node)
      end
  
      private
  
      def has_statement?(node)
        found_statement = false
        found_statement = found_statement || node.node_type == :fcall
        node.children.each { |child| found_statement = found_statement || has_statement?(child) }
        found_statement
      end
    end
  end
end
