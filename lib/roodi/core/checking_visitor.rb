require 'java'
include_class 'org.jruby.ast.visitor.AbstractVisitor'

module Roodi
  module Core
    class CheckingVisitor < AbstractVisitor
      def checks=(checks)
        @checks ||= {}
        checks.each do |check|
          nodes = check.interesting_nodes
          nodes.each do |node|
            @checks[node] ||= []
            @checks[node] << check
            @checks[node].uniq!
          end
        end
      end

      def visitNode(node)
        checks = @checks[node.class]
        checks.each {|check| check.evaluate(node)} unless checks.nil?
        nil
      end
    end
  end
end
