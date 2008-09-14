require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks a class name to make sure it matches the specified pattern.
    # 
    # Keeping to a consistent nameing convention makes your code easier to read.
    class ClassNameCheck < Check
      DEFAULT_PATTERN = /^[A-Z][a-zA-Z0-9]*$/
      
      def initialize(options = {})
        super()
        @pattern = options['pattern'] || DEFAULT_PATTERN
      end
      
      def interesting_nodes
        [:class]
      end
  
      def evaluate(node)
        class_name = node[1].class == Symbol ? node[1] : node[1].last
        add_error "Class name \"#{class_name}\" should match pattern #{@pattern.inspect}" unless class_name.to_s =~ @pattern
      end
    end
  end
end
