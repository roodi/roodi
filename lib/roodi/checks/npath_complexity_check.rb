require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks NPATH complexity of a node
    #
    # NPATH counts acyclic execution paths in a piece of code.
    # Here is an article by Brian A. Nejmeh that explains it in more detail:
    # http://www.accessmylibrary.com/article-1G1-6242192/npath-measure-execution-path.html
    class NpathComplexityCheck < Check
      # , :when, :and, :or
      MULTIPLYING_NODE_TYPES = [:if, :while, :until, :for, :case]
      ADDING_NODE_TYPES = [:rescue]
      COMPLEXITY_NODE_TYPES = MULTIPLYING_NODE_TYPES + ADDING_NODE_TYPES

      attr_accessor :complexity

      def initialize(complexity)
        super()
        @complexity = complexity
        @value_stack = []
        @current_value = 1
      end

      def evalute_start_if(node)
        push_value
      end

      def evalute_start_while(node)
        push_value
      end

      def evalute_start_until(node)
        push_value
      end

      def evalute_start_for(node)
        push_value
      end

      def evalute_start_case(node)
        push_value
      end

      def evalute_start_rescue(node)
        push_value
      end

      MULTIPLYING_NODE_TYPES.each do |type|
        define_method "evaluate_end_#{type}" do |node|
          leave_multiplying_conditional
        end
      end

      ADDING_NODE_TYPES.each do |type|
        define_method "evaluate_end_#{type}" do |node|
          leave_multiplying_conditional
        end
      end

      protected

      def push_value
        @value_stack.push @current_value
        @current_value = 1
      end

      def leave_multiplying_conditional
        pop = @value_stack.pop
        @current_value = (@current_value + 1) * pop
      end

      def leave_adding_conditional
        pop = @value_stack.pop
        puts "#{type}, so adding #{pop}"
        @current_value = @current_value - 1 + pop
      end
    end
  end
end
