require 'roodi/checks/check'

module Roodi
  module Checks
    class CyclomaticComplexityCheck < Check
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
        complexity_node_types = [:if, :while, :until, :for, :rescue, :case, :when, :and, :or]
        
        count = 0
        count = count + 1 if complexity_node_types.include? node.node_type
        node.children.each {|node| count += count_branches(node)}
        count
      end
    end
  end
end
