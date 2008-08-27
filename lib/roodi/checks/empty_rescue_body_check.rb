require 'java'
require 'roodi/checks/check'
include_class 'org.jruby.ast.RescueBodyNode'
include_class 'org.jruby.ast.NewlineNode'

module Roodi
  module Checks
    class EmptyRescueBodyCheck < Check
      def interesting_nodes
        [RescueBodyNode]
      end

      def evaluate(node)
        add_error "#{position(node)} - Rescue block should not be empty." unless has_statement?(node)
      end
  
      private
  
      def has_statement?(node)
        found_statement = false
        if (node)
          found_statement = found_statement || node.class == NewlineNode
          children = node.childNodes
          children.each { |child| found_statement = found_statement || has_statement?(child) } if children
        end
        found_statement
      end
    end
  end
end
