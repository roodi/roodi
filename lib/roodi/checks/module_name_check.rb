require 'roodi/checks/name_check'

module Roodi
  module Checks
    # Checks a module name to make sure it matches the specified pattern.
    # 
    # Keeping to a consistent nameing convention makes your code easier to read.
    class ModuleNameCheck < NameCheck
      DEFAULT_PATTERN = /^[A-Z][a-zA-Z0-9]*$/
      
      def initialize(options = {})
        pattern = options['pattern'] || DEFAULT_PATTERN
        super([:module], pattern, 'Module')
      end
      
      def find_name(node)
        node[1].class == Symbol ? node[1] : node[1].last
      end
    end
  end
end
