require 'roodi/checks/check'

module Roodi
  module Checks
    class MethodNameCheck < Check
      def interesting_nodes
        [:defn]
      end

      def evaluate(node)
        pattern = /^[a-z<>=\[\]]+[a-z0-9_<>=\[\]]*[=!\?]?$/
        add_error "#{position(node)} - Method name \"#{node[1]}\" should match pattern #{pattern.inspect}" unless node[1].to_s =~ pattern
      end
    end
  end
end
