require 'java'
require 'checks/check'
include_class 'org.jruby.ast.FixnumNode'
include_class 'org.jruby.ast.BignumNode'

class MagicNumberCheck < Check
  def interesting_nodes
    [FixnumNode, BignumNode]
  end

  def evaluate(node)
    add_error "#{position(node)} - #{node.getValue} is a magic number.  Use a meaningful constant or variable instead." unless [-1,0,1,2].include? node.getValue
  end
end