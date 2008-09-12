require 'roodi/checks/check'

module Roodi
  module Checks
    class CaseMissingElseCheck < Check
      def interesting_nodes
        [:case]
      end
  
      def evaluate(node)
        add_error "Case statement is missing an else clause." unless node.last
      end
    end
  end
end
