module Roodi
  module Core
    class CheckingVisitor
      def initialize(*checks)
        @checks ||= {}
        checks.first.each do |check|
          nodes = check.interesting_nodes
          nodes.each do |node|
            @checks[node] ||= []
            @checks[node] << check
            @checks[node].uniq!
          end
        end
      end

      def visit(node)
        checks = @checks[node.node_type]
        checks.each {|check| check.evaluate(node)} unless checks.nil?
        nil
      end
    end
  end
end
