require 'roodi/checks/name_check'

module Roodi
  module Checks
    # Checks a class name to make sure it matches the specified pattern.
    # 
    # Keeping to a consistent naming convention makes your code easier to read.
    class ClassNameCheck < NameCheck
      DEFAULT_PATTERN = /^[A-Z][a-zA-Z0-9]*$/
      
      def initialize(options = {})
        pattern = options['pattern'] || DEFAULT_PATTERN
        super([:class], pattern, 'Class')
      end
      
      def find_name(node)
        node[1].class == Symbol ? node[1] : node[1].last
      end
    end
  end
end
