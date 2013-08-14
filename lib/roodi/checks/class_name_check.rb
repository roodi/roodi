require 'roodi/checks/name_check'

module Roodi
  module Checks
    # Checks a class name to make sure it matches the specified pattern.
    #
    # Keeping to a consistent naming convention makes your code easier to read.
    class ClassNameCheck < NameCheck

      DEFAULT_PATTERN = /^[A-Z][a-zA-Z0-9]*$/

      def initialize
        super()
        self.pattern = DEFAULT_PATTERN
      end

      def interesting_nodes
        [:class]
      end

      def message_prefix
        'Class'
      end

    end
  end
end
