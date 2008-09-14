require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks a module name to make sure it matches the specified pattern.
    # 
    # Keeping to a consistent nameing convention makes your code easier to read.
    class ModuleNameCheck < Check
      DEFAULT_PATTERN = /^[A-Z][a-zA-Z0-9]*$/
      
      def initialize(options = {})
        super()
        @pattern = options['pattern'] || DEFAULT_PATTERN
      end

      def interesting_nodes
        [:module]
      end
  
      def evaluate(node)
        module_name = node[1].class == Symbol ? node[1] : node[1].last
        add_error "Module name \"#{module_name}\" should match pattern #{@pattern.inspect}" unless module_name.to_s =~ @pattern
      end
    end
  end
end
