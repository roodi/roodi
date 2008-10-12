require 'roodi/checks/check'

module Roodi
  module Checks
    class CyclomaticComplexityCheck < Check
      COMPLEXITY_NODE_TYPES = [:if, :while, :until, :for, :rescue, :case, :when, :and, :or]

      def initialize(complexity)
        super()
        @complexity = complexity
      end
      
      protected
      
      def count_complexity(node)
        count_branches(node) + 1
      end

      private

      def count_branches(node)
        count = 0
        count = count + 1 if COMPLEXITY_NODE_TYPES.include? node.node_type
        node.children.each {|node| count += count_branches(node)}
        count
      end
    end
  end
end
