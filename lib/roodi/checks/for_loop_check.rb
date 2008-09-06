require 'roodi/checks/check'

module Roodi
  module Checks
    class ForLoopCheck < Check
      def interesting_nodes
        [:for]
      end

      def evaluate(node)
        add_error "#{position(node)} - Don't use 'for' loops. Use Enumerable.each instead."
      end
    end
  end
end
