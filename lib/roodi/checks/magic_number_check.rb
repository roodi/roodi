require 'roodi/checks/check'

module Roodi
  module Checks
    class MagicNumberCheck < Check
      def interesting_nodes
        [:fixnum, :bignum]
      end

      def evaluate(node)
        add_error "#{position(node)} - #{node.getValue} is a magic number.  Use a meaningful constant or variable instead." unless [-1,0,1,2].include? node.getValue
      end
    end
  end
end
