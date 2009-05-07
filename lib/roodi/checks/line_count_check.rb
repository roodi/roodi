require 'roodi/checks/check'

module Roodi
  module Checks
    class LineCountCheck < Check
      def initialize(interesting_nodes, line_count, message_prefix)
        super()
        @interesting_nodes = interesting_nodes
        @line_count = line_count
        @message_prefix = message_prefix
      end

      def interesting_nodes
        @interesting_nodes
      end

      def evaluate(node)
        line_count = count_lines(node)
        add_error "#{@message_prefix} \"#{node[1]}\" has #{line_count} lines.  It should have #{@line_count} or less." unless line_count <= @line_count
      end

      protected
  
      def count_lines(node)
        node.last.line - 2
      end
    end
  end
end
