require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks a case statement to make sure it has an 'else' clause.
    # 
    # It's usually a good idea to have an else clause in every case statement. Even if the 
    # developer is sure that all currently possible cases are covered, this should be 
    # expressed in the else clause. This way the code is protected aginst later changes, 
    class CaseMissingElseCheck < Check
      def interesting_nodes
        [:case]
      end
  
      def evaluate_start(node)
        add_error "Case statement is missing an else clause." unless node.last
      end
    end
  end
end
