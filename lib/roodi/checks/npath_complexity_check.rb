require 'roodi/checks/check'

module Roodi
  module Checks
    class NpathComplexityCheck < Check
      # , :when, :and, :or
      MULTIPLYING_NODE_TYPES = [:if, :while, :until, :for, :case]
      ADDING_NODE_TYPES = [:rescue]
      COMPLEXITY_NODE_TYPES = MULTIPLYING_NODE_TYPES + ADDING_NODE_TYPES

      def initialize(complexity)
        super()
        @complexity = complexity
        @value_stack = []
        @current_value = 1
      end
      
      COMPLEXITY_NODE_TYPES.each do |type|
        define_method "evaluate_start_#{type}" do
          @value_stack.push @current_value
          @current_value = 1
        end
      end
      
      MULTIPLYING_NODE_TYPES.each do |type|
        define_method "evaluate_end_#{type}" do
          pop = @value_stack.pop
          @current_value = (@current_value + 1) * pop
        end
      end

      ADDING_NODE_TYPES.each do |type|
        define_method "evaluate_end_#{type}" do
          pop = @value_stack.pop
          @current_value = @current_value - 1 + pop
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
