require 'java'
require 'checks/check'
include_class 'org.jruby.ast.FixnumNode'
include_class 'org.jruby.ast.BignumNode'

class MagicNumberCheck < Check
  def interested_in?(node)
    node.class == FixnumNode or node.class == BignumNode
  end

  def evaluate(node)
    if interested_in?(node)
      puts "#{position(node)} - #{node.getValue} is a magic number.  Use a meaningful constant or variable instead." unless [-1,0,1,2].include? node.getValue
    end
  end
end