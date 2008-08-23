require 'java'
require 'checks/check'
include_class 'org.jruby.ast.DefnNode'
include_class 'org.jruby.ast.NewlineNode'

class MethodLineCountCheck < Check
  def interested_in?(node)
    node.class == DefnNode
  end

  def evaluate(node)
    if interested_in?(node)
      line_count = count_lines(node)
      puts "#{position(node)} - Method name \"#{node.getName}\" has #{line_count} lines.  It should have 5 or less." unless line_count <= 5
    end
  end
  
  def count_lines(node)
    count = 0
    count = count + 1 if node.class == NewlineNode
    node.childNodes.each {|node| count += count_lines(node)}
    count
  end
end