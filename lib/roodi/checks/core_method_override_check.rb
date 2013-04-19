require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks a class to make sure it doesn't override core methods on Object.
    #
    # An example is when the 'class' method of a class is overriden.  This causes code
    # that tests the class of an object to fail.
    class CoreMethodOverrideCheck < Check

      def interesting_nodes
        [:defn]
      end

      def evaluate_start(node)
        [ :class ].each do |core_name|
          add_error("Class overrides method '#{core_name}'.") if node[1] == core_name
        end
      end

    end
  end
end