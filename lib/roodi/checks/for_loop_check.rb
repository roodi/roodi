require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks to make sure for loops are not being used..
    # 
    # Using a for loop is not idiomatic use of Ruby, and is usually a sign that someone with 
    # more experience in a different programming language is trying out Ruby.  Use 
    # Enumerable.each with a block instead.
    class ForLoopCheck < Check
      def interesting_nodes
        [:for]
      end

      def evaluate_start(node)
        add_error "Don't use 'for' loops. Use Enumerable.each instead."
      end
    end
  end
end
