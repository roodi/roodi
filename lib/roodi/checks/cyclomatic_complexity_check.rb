require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks cyclomatic complexity against a specified limit. The complexity is
    # measured by the number of "if", "unless", "elsif", "?:", "while", "until", 
    # "for", "rescue", "case", "when", "&amp;&amp;", "and", "||" and "or" statements (plus 
    # one) in the body of the member. It is a measure of the minimum number of 
    # possible paths through the source and therefore the number of required tests. 
    # Generally 1-4 is considered good, 5-7 ok, 8-10 consider re-factoring, and 
    # 11+ re-factor now!
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
