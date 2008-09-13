require 'roodi/checks/cyclomatic_complexity_check'

module Roodi
  module Checks
    class CyclomaticComplexityBlockCheck < CyclomaticComplexityCheck
      DEFAULT_COMPLEXITY = 4
      
      def initialize(options = {})
        complexity = options['complexity'] || DEFAULT_COMPLEXITY
        super(complexity)
      end
      
      def interesting_nodes
        [:iter]
      end

      def evaluate(node)
        complexity = count_complexity(node)
        add_error "Block cyclomatic complexity is #{complexity}.  It should be #{@complexity} or less." unless complexity <= @complexity
      end
    end
  end
end
