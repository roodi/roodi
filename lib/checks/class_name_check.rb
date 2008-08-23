require 'java'
require 'checks/check'
include_class 'org.jruby.ast.ClassNode'

class ClassNameCheck < Check
  def interested_in?(node)
    node.class == ClassNode
  end
  
  def evaluate(node)
    if interested_in?(node)
      pattern = /^[A-Z][a-zA-Z0-9]*$/
      puts "#{position(node)} - Class name \"#{node.getCPath.getName}\" should match pattern #{pattern}." unless node.getCPath.getName =~ pattern
    end
  end
end