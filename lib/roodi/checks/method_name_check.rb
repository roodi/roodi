require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks a method name to make sure it matches the specified pattern.
    # 
    # Keeping to a consistent nameing convention makes your code easier to read.
    class MethodNameCheck < Check
      DEFAULT_PATTERN = /^[_a-z<>=\[\]|+-\/\*`]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/
      
      def initialize(options = {})
        super()
        @pattern = options['pattern'] || DEFAULT_PATTERN
      end

      def interesting_nodes
        [:defn]
      end

      def evaluate(node)
        method_name = node[1]
        add_error "Method name \"#{method_name}\" should match pattern #{@pattern.inspect}" unless method_name.to_s =~ @pattern
      end
    end
  end
end
