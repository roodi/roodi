require 'roodi/checks/check'

module Roodi
  module Checks
    # Cyclomatic complexity counts the number of linearly independent paths in
    # the code. The lower the score, the better.
    #
    # Read more in the inventor Thomas J. McCabe's original research
    # paper: www.literateprogramming.com/mccabe.pdf
    class CyclomaticComplexityCheck < Check

      COMPLEXITY_NODE_TYPES = [:if, :while, :until, :for, :rescue, :case, :when, :and, :or]

      attr_accessor :complexity

      def initialize
        super()
        @count = 0
        @counting = 0
      end

      COMPLEXITY_NODE_TYPES.each do |type|
        define_method "evaluate_start_#{type}" do |node|
          @count = @count + 1 if counting?
        end
      end

      protected

      def count_complexity(node)
        count_branches(node) + 1
      end

      def increase_depth
        @count = 1 unless counting?
        @counting = @counting + 1
      end

      def decrease_depth
        @counting = @counting - 1
        if @counting <= 0
          @counting = 0
          evaluate_matching_end
        end
      end

      private

      def counting?
        @counting > 0
      end

    end
  end
end
