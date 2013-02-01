require 'roodi/checks/check'

module Roodi
  module Checks
    class LineCountCheck < Check

      attr_accessor :line_count

      def evaluate_start(node)
        line_count = count_lines(node)
        add_error "#{message_prefix} \"#{node[1]}\" has #{line_count} lines.  It should have #{@line_count} or less." unless line_count <= @line_count
      end

      protected

      def count_lines(node)
        node.last.line - node.line - 1
      rescue NoMethodError => e
        STDERR.puts "!! line counting error #{e.message}\t #{node.inspect}"
        STDERR.puts "!! Does the node have any lines?"
        0
      end

    end
  end
end
