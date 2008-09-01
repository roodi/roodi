require 'java'
require 'roodi/checks/check'
include_class 'org.jruby.ast.DefnNode'

module Roodi
  module Checks
    class MethodNameCheck < Check
      def interesting_nodes
        [DefnNode]
      end

      def evaluate(node)
          pattern = /^[a-z]+[a-z0-9_]*[!\?]?$/
        add_error "#{position(node)} - Method name \"#{node.getName}\" should match pattern #{pattern}." unless node.getName =~ pattern
      end
    end
  end
end
