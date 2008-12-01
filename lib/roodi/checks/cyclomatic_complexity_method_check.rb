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
      
      def initialize(options = {})
        complexity = options['complexity'] || DEFAULT_COMPLEXITY
        super(complexity)
      end
      
      def interesting_nodes
        [:defn]
      end

      def evaluate(node)
        complexity = count_complexity(node)
        add_error "Method name \"#{node[1]}\" cyclomatic complexity is #{complexity}.  It should be #{@complexity} or less." unless complexity <= @complexity
      end
    end
  end
end
