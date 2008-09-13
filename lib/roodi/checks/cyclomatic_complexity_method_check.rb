require 'roodi/checks/cyclomatic_complexity_check'

module Roodi
  module Checks
    class CyclomaticComplexityMethodCheck < CyclomaticComplexityCheck
      DEFAULT_COMPLEXITY = 8
      
      def initialize(options = {})
        complexity = options['complexity'] || DEFAULT_COMPLEXITY
        super(complexity)
      end
      
      def interesting_nodes
        [:defn]
      end

      def evaluate(node)
        complexity = count_complexity(node)
        add_error "Method name \"#{node[1]}\" has a cyclomatic complexity is #{complexity}.  It should be #{@complexity} or less." unless complexity <= @complexity
      end
    end
  end
end
