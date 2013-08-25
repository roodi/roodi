require 'roodi/core/error'

module Roodi
  module Checks
    # Base class for all the checks
    class Check

      NODE_TYPES = [:defn, :module, :resbody, :lvar, :cvar, :class, :if, :while, :until, :for, :rescue, :case, :when, :and, :or]

      class << self

        def make(options = nil)
          check = new
          if options
            options.each do |name, value|
              check.send("#{name}=", value)
            end
          end
          check
        end

      end

      def initialize
        @errors = []
      end

      NODE_TYPES.each do |node|
        start_node_method = "evaluate_start_#{node}"
        end_node_method = "evaluate_end_#{node}"
        define_method(start_node_method) { |start_node| return } unless self.respond_to?(start_node_method)
        define_method(end_node_method) { |end_node| return } unless self.respond_to?(end_node_method)
      end

      def position(offset = 0)
        "#{@line[2]}:#{@line[1] + offset}"
      end

      def start_file(filename)
      end

      def end_file(filename)
      end

      def evaluate_start(node)
      end

      def evaluate_end(node)
      end

      def evaluate_node(position, node)
        @node = node
        eval_method = "evaluate_#{position}_#{node.node_type}"
        self.send(eval_method, node)
      end

      def evaluate_node_start(node)
        evaluate_node(:start, node)
        evaluate_start(node)
      end

      def evaluate_node_end(node)
        evaluate_node(:end, node)
        evaluate_end(node)
      end

      def add_error(error, filename = @node.file, line = @node.line)
        @errors ||= []
        @errors << Roodi::Core::Error.new("#{filename}", "#{line}", error)
      end

      def errors
        @errors
      end
    end
  end
end
