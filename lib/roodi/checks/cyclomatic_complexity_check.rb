require 'java'
require 'roodi/checks/check'
include_class 'org.jruby.ast.ForNode'

module Roodi
  module Checks
    class CyclomaticComplexityCheck < Check
      def interesting_nodes
        [DefnNode]
      end

      def evaluate(node)
        complexity = count_complexity(node)
        add_error "#{position(node)} - Cyclomatic complexity is #{complexity}.  It should be 0 or less." unless complexity <= 0
      end
      
      def count_complexity(node)
        count = 0
        count = count + 2 if node.class == IfNode
        node.childNodes.each {|node| count += count_complexity(node)}
        count
      end
    end
  end
end
