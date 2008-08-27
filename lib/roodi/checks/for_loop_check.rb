require 'java'
require 'roodi/checks/check'
include_class 'org.jruby.ast.ForNode'

class ForLoopCheck < Check
  def interesting_nodes
    [ForNode]
  end

  def evaluate(node)
    add_error "#{position(node)} - Don't use 'for' loops. Use Enumerable.each instead."
  end
end