require 'roodi/checks/check'

module Roodi
  module Checks
    class ClassNameCheck < Check
      def initialize(pattern = /^[A-Z][a-zA-Z0-9]*$/)
        super()
        @pattern = pattern
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
