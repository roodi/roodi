require 'roodi/checks/check'

module Roodi
  module Checks
    # The ABC metric method check calculates the number of Assignments,
    # Branches and Conditionals in your code. It is similar to
    # cyclomatic complexity, so the lower the better.
    class AbcMetricMethodCheck < Check
      ASSIGNMENTS = [:lasgn]
      BRANCHES = [:vcall, :call]
      CONDITIONS = [:==, :"!=", :<=, :>=, :<, :>]
      OPERATORS = [:*, :/, :%, :+, :<<, :>>, :&, :|, :^]
      DEFAULT_SCORE = 10

      attr_accessor :score

      def initialize
        super()
        self.score = DEFAULT_SCORE
      end

      def interesting_nodes
        [:defn]
      end

      def evaluate_start(node)
        method_name = node[1]
        a = count_assignments(node)
        b = count_branches(node)
        c = count_conditionals(node)
        score = Math.sqrt(a*a + b*b + c*c)
        add_error "Method name \"#{method_name}\" has an ABC metric score of <#{a},#{b},#{c}> = #{score}.  It should be #{@score} or less." unless score <= @score
      end

      private

      def count_assignments(node)
        count = assignment?(node) ? 1 : 0
        node.children.each {|child_node| count += count_assignments(child_node)}
        count
      end

      def count_branches(node)
        count = branch?(node) ? 1 : 0
        node.children.each {|child_node| count += count_branches(child_node)}
        count
      end

      def count_conditionals(node)
        count = conditional?(node) ? 1 : 0
        node.children.each {|child_node| count += count_conditionals(child_node)}
        count
      end

      def assignment?(node)
        ASSIGNMENTS.include?(node.node_type)
      end

      def branch?(node)
        BRANCHES.include?(node.node_type) && !conditional?(node) && !operator?(node)
      end

      def conditional?(node)
        (:call == node.node_type) && CONDITIONS.include?(node[2])
      end

      def operator?(node)
        (:call == node.node_type) && OPERATORS.include?(node[2])
      end
    end
  end
end
