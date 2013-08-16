require 'roodi/checks/npath_complexity_check'

module Roodi
  module Checks
    # Checks NPATH complexity of a method against a specified limit.
    class NpathComplexityMethodCheck < NpathComplexityCheck

      DEFAULT_COMPLEXITY = 8

      def initialize
        super(DEFAULT_COMPLEXITY)
      end

      def interesting_nodes
        [:defn] + COMPLEXITY_NODE_TYPES
      end

      def evaluate_start_defn(node)
        @method_name = @node[1]
        push_value
      end

      def evaluate_end_defn(node)
        add_error "Method name \"#{@method_name}\" n-path complexity is #{@current_value}.  It should be #{@complexity} or less." unless @current_value <= @complexity
      end

    end
  end
end
