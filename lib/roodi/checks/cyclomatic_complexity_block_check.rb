require 'java'
require 'roodi/checks/cyclomatic_complexity_check'
require 'roodi/jruby'

module Roodi
  module Checks
    class CyclomaticComplexityBlockCheck < CyclomaticComplexityCheck
      def initialize(complexity = 4)
        super(complexity)
      end
      
      def interesting_nodes
        [IterNode]
      end

      def evaluate(node)
        complexity = count_complexity(node)
        add_error "#{position(node)} - Block cyclomatic complexity is #{complexity}.  It should be #{@complexity} or less." unless complexity <= @complexity
      end
    end
  end
end
