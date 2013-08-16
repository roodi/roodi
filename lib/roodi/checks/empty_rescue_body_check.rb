require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks the body of a rescue block to make sure it's not empty..
    #
    # When the body of a rescue block is empty, exceptions can get caught and swallowed without
    # any feedback to the user.
    class EmptyRescueBodyCheck < Check

      def interesting_nodes
        [:resbody]
      end

      def evaluate_start(node)
        add_error("Rescue block should not be empty.") if node.children[1].nil?
      end

    end
  end
end
