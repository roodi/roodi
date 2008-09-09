module Roodi
  module Checks
    class Check
      def initialize
        @errors = []
      end
  
      def position(offset = 0)
        "#{@line[2]}:#{@line[1] + offset}"
      end
  
      def evaluate_node_at_line(node, line)
        @line = line
        evaluate(node)
      end
  
      def add_error(error, offset = 0)
        @errors << "#{position(offset)} - #{error}"
      end
  
      def errors
        @errors
      end
    end
  end
end
