require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks how many lines there are in a ruby_parser node
    class LineCountCheck < Check

      attr_accessor :line_count

      def evaluate_start(node)
        line_count = count_lines(node)
        add_error "#{message_prefix} \"#{node[1]}\" has #{line_count} lines.  It should have #{@line_count} or less." unless line_count <= @line_count
      end

      protected

      def count_lines(node)
        node.last.respond_to?(:line) ? node.last.line - node.line : 0
      end

    end
  end
end
