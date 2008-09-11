require 'roodi/checks/check'

module Roodi
  module Checks
    class ModuleNameCheck < Check
      def interesting_nodes
        [:module]
      end
  
      def evaluate(node)
        class_name = node[1].class == Symbol ? node[1] : node[1].last
        pattern = /^[A-Z][a-zA-Z0-9]*$/
        add_error "Module name \"#{node[1]}\" should match pattern #{pattern.inspect}" unless class_name.to_s =~ pattern
      end
    end
  end
end
