require 'roodi/checks/check'

module Roodi
  module Checks
    class NameCheck < Check
      def initialize(interesting_nodes, pattern, message_prefix)
        super()
        @interesting_nodes = interesting_nodes
        @pattern = pattern
        @message_prefix = message_prefix
      end

      def interesting_nodes
        @interesting_nodes
      end

      def evaluate(node)
        name = find_name(node)
        add_error "#{@message_prefix} name \"#{name}\" should match pattern #{@pattern.inspect}" unless name.to_s =~ @pattern
      end
    end
  end
end
