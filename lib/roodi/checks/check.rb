require 'roodi/core/error'

module Roodi
  module Checks
    class Check
      def initialize
        @errors = []
      end
  
      def position(offset = 0)
        "#{@line[2]}:#{@line[1] + offset}"
      end

      def evaluate_node(node)
        @node = node
        eval_method = "evaluate_#{node.node_type}"
        self.send(eval_method, node) if self.respond_to? eval_method
        evaluate(node) if self.respond_to? :evaluate
      end
  
      def add_error(error)
        @errors << Roodi::Core::Error.new("#{@node.file}", "#{@node.line}", error)
      end
  
      def errors
        @errors
      end
    end
  end
end
