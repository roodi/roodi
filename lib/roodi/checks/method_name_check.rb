require 'roodi/checks/name_check'

module Roodi
  module Checks
    # Checks a method name to make sure it matches the specified pattern.
    #
    # Keeping to a consistent nameing convention makes your code easier to read.
    class MethodNameCheck < NameCheck

      DEFAULT_PATTERN = /^[_a-z<>=\[|+-\/\*`]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/

      def initialize
        super()
        self.pattern = DEFAULT_PATTERN
      end

      def interesting_nodes
        [:defn]
      end

      def message_prefix
        'Method'
      end

      def find_name(node)
        node[1]
      end

    end
  end
end
