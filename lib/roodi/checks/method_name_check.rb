require 'roodi/checks/check'

module Roodi
  module Checks
    class MethodNameCheck < Check
      DEFAULT_PATTERN = /^[_a-z<>=\[\]|+-\/\*`]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/
      
      def initialize(options = {})
        super()
        @pattern = options[:pattern] || DEFAULT_PATTERN
      end

      def interesting_nodes
        [:defn]
      end

      def evaluate(node)
        pattern = /^[_a-z<>=\[\]|+-\/\*`]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/
        add_error "Method name \"#{node[1]}\" should match pattern #{@pattern.inspect}" unless node[1].to_s =~ @pattern
      end
    end
  end
end
