require 'java'
require 'checks/check'
include_class 'org.jruby.ast.DefnNode'
include_class 'org.jruby.ast.NewlineNode'

class MethodLineCountCheck < Check
  def interesting_nodes
    [DefnNode]
  end

  def evaluate(node)
    line_count = count_lines(node)
    puts "#{position(node)} - Method name \"#{node.getName}\" has #{line_count} lines.  It should have 5 or less." unless line_count <= 5
  end
  
  def count_lines(node)
    count = 0
    count = count + 1 if node.class == NewlineNode
    node.childNodes.each {|node| count += count_lines(node)}
    count
  end
end