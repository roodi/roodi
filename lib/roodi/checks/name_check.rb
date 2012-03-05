require 'roodi/checks/check'

module Roodi
  module Checks
    class NameCheck < Check

      attr_accessor :pattern

      def evaluate_start(node)
        name = find_name(node)
        add_error "#{message_prefix} name \"#{name}\" should match pattern #{@pattern.inspect}" unless name.to_s =~ @pattern
      end

    end
  end
end
