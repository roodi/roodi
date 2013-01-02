require 'roodi/checks/cyclomatic_complexity_check'

module Roodi
  module Checks
    # Checks cyclomatic complexity of a method against a specified limit. 
    # 
    # The cyclomatic complexity is measured by the number of "if", "unless", "elsif", "?:", 
    # "while", "until", "for", "rescue", "case", "when", "&amp;&amp;", "and", "||" and "or" 
    # statements (plus one) in the body of the member. It is a measure of the minimum 
    # number of possible paths through the source and therefore the number of required tests. 
    #
    # Generally, for a method, 1-4 is considered good, 5-8 ok, 9-10 consider re-factoring, and 
    # 11+ re-factor now!
    class CyclomaticComplexityMethodCheck < CyclomaticComplexityCheck
      
      DEFAULT_COMPLEXITY = 8
      
      def initialize
        super()
        self.complexity = DEFAULT_COMPLEXITY
      end
      
      def interesting_nodes
        [:defn] + COMPLEXITY_NODE_TYPES
      end

      def evaluate_start_defn(node)
        @method_name = @node[1]
        increase_depth
      end

      def evaluate_end_defn(node)
        decrease_depth
      end
      
      def evaluate_matching_end
        add_error "Method name \"#{@method_name}\" cyclomatic complexity is #{@count}.  It should be #{@complexity} or less." unless @count <= @complexity
      end

    end
  end
end
