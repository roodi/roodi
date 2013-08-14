require 'roodi/checks/name_check'

module Roodi
  module Checks
    # Checks a module name to make sure it matches the specified pattern.
    #
    # Keeping to a consistent nameing convention makes your code easier to read.
    class ModuleNameCheck < NameCheck

      DEFAULT_PATTERN = /^[A-Z][a-zA-Z0-9]*$/

      def initialize
        super()
        self.pattern = DEFAULT_PATTERN
      end

      def interesting_nodes
        [:module]
      end

      def message_prefix
        'Module'
      end

    end
  end
end
