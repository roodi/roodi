require 'roodi/checks/check'

module Roodi
  module Checks
    class ControlCouplingCheck < Check
      def interesting_nodes
        [:defn, :lvar]
      end

      def evaluate_start_defn(node)
        @method_name = node[1]
        @arguments = node[2][1..-1]
      end
        
      def evaluate_start_lvar(node)
        add_error "Method \"#{@method_name}\" uses the argument \"#{node[1]}\" for internal control." if @arguments.detect {|each| each == node[1]}
      end
    end
  end
end
