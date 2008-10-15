require 'roodi/checks/check'

module Roodi
  module Checks
    # TODO:  Add summary
    # 
    # TODO:  Add detail
    class AbcMetricMethodCheck < Check
      # ASSIGNMENTS = [:attrasgn, :attrset, :dasgn_curr, :iasgn, :lasgn, :masgn]
      ASSIGNMENTS = [:lasgn]
      # BRANCHES = [:if, :else, :while, :until, :for, :rescue, :case, :when, :and, :or]
      BRANCHES = [:vcall, :call]
      # CONDITIONS = [:and, :or]
      CONDITIONS = [:==, :<=, :>=, :<, :>]
      #  =  *=  /=  %=  +=  <<=  >>=  &=  |=  ^=
      OPERATORS = [:*, :/, :%, :+, :<<, :>>, :&, :|, :^]
      DEFAULT_SCORE = 10
      
      def initialize(options = {})
        super()
        @score = options['score'] || DEFAULT_SCORE
      end
      
      def interesting_nodes
        [:defn]
      end

      def evaluate(node)
        method_name = node[1]
        a = count_assignments(node)
        b = count_branches(node)
        c = count_conditionals(node)
        score = Math.sqrt(a*a + b*b + c*c)
        add_error "Method name \"#{method_name}\" has an ABC metric score of <#{a},#{b},#{c}> = #{score}.  It should be #{@score} or less." unless score <= @score
      end
      
      private

      def count_assignments(node)
        count = 0
        count = count + 1 if assignment?(node)
        node.children.each {|node| count += count_assignments(node)}
        count
      end
      
      def count_branches(node)
        count = 0
        count = count + 1 if branch?(node)
        node.children.each {|node| count += count_branches(node)}
        count
      end

      def count_conditionals(node)
        count = 0
        count = count + 1 if conditional?(node)
        node.children.each {|node| count += count_conditionals(node)}
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
