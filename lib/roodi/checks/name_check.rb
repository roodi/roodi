require 'roodi/checks/check'

module Roodi
  module Checks
    class NameCheck < Check

      attr_accessor :pattern

      def evaluate_start(node)
        name = find_name(node)
        add_error "#{message_prefix} name \"#{name}\" should match pattern #{@pattern.inspect}" unless name.to_s =~ @pattern
      end

      def find_name(node)
        node[1].class == Symbol ? node[1] : node[1].last
      end

    end
  end
end
