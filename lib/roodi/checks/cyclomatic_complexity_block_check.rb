require 'roodi/checks/cyclomatic_complexity_check'

module Roodi
  module Checks
    # Checks cyclomatic complexity of a block against a specified limit. 
    # 
    # The cyclomatic complexity is measured by the number of "if", "unless", "elsif", "?:", 
    # "while", "until", "for", "rescue", "case", "when", "&amp;&amp;", "and", "||" and "or" 
    # statements (plus one) in the body of the member. It is a measure of the minimum 
    # number of possible paths through the source and therefore the number of required tests. 
    #
    # Generally, for a block, 1-2 is considered good, 3-4 ok, 5-8 consider re-factoring, and 8+ 
    # re-factor now!
    class CyclomaticComplexityBlockCheck < CyclomaticComplexityCheck

      DEFAULT_COMPLEXITY = 4
      
      def initialize
        super()
        self.complexity = DEFAULT_COMPLEXITY
      end
      
      def interesting_nodes
        [:iter] + COMPLEXITY_NODE_TYPES
      end

      def evaluate_start_iter(node)
        increase_depth
      end

      def evaluate_end_iter(node)
        decrease_depth
      end
      
      def evaluate_matching_end
        add_error "Block cyclomatic complexity is #{@count}.  It should be #{@complexity} or less." unless @count <= @complexity
      end

    end
  end
end
