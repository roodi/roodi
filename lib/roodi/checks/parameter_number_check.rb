require 'roodi/checks/check'

module Roodi
  module Checks
    class ParameterNumberCheck < Check
      DEFAULT_PARAMETER_COUNT = 5
      
      def initialize(options = {})
        super()
        @parameter_count = options['parameter_count'] || DEFAULT_PARAMETER_COUNT
      end
      
      def interesting_nodes
        [:defn]
      end

      def evaluate(node)
        method_name = node[1]
        arguments = node[2][1][1]
        parameter_count = arguments.inject(-1) { |count, each| count = count + (each.class == Symbol ? 1 : 0) }
        add_error "Method name \"#{method_name}\" has #{parameter_count} parameters.  It should have #{@parameter_count} or less." unless parameter_count <= @parameter_count
      end
    end
  end
end
