require 'roodi/checks/check'

module Roodi
  module Checks
    class MethodLineCountCheck < Check
      DEFAULT_LINE_COUNT = 20
      
      def initialize(options = {})
        super()
        @line_count = options[:line_count] || DEFAULT_LINE_COUNT
      end
      
      def interesting_nodes
        [:defn]
      end

      def evaluate(node)
        line_count = count_lines(node)
        add_error "Method name \"#{node[1]}\" has #{line_count} lines.  It should have #{@line_count} or less." unless line_count <= @line_count
      end
  
      private
  
      def count_lines(node)
        count = 0
        count = count + 1 if node.node_type == :newline
        node.children.each {|node| count += count_lines(node)}
        count
      end
    end
  end
end
