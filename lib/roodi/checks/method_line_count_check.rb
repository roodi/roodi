require 'java'
require 'roodi/checks/check'
include_class 'org.jruby.ast.DefnNode'
include_class 'org.jruby.ast.NewlineNode'

module Roodi
  module Checks
    class MethodLineCountCheck < Check
      def initialize(line_count = 20)
        super()
        @line_count = line_count
      end
      
      def interesting_nodes
        [DefnNode]
      end

      def evaluate(node)
        line_count = count_lines(node)
        add_error "#{position(node)} - Method name \"#{node.getName}\" has #{line_count} lines.  It should have #{@line_count} or less." unless line_count <= @line_count
      end
  
      private
  
      def count_lines(node)
        count = 0
        count = count + 1 if node.class == NewlineNode
        node.childNodes.each {|node| count += count_lines(node)}
        count
      end
    end
  end
end
