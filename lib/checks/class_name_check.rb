require 'java'
require 'checks/check'
include_class 'org.jruby.ast.ClassNode'

class ClassNameCheck < Check
  def interesting_nodes
    [ClassNode]
  end
  
  def evaluate(node)
    pattern = /^[A-Z][a-zA-Z0-9]*$/
    add_error "#{position(node)} - Class name \"#{node.getCPath.getName}\" should match pattern #{pattern}." unless node.getCPath.getName =~ pattern
  end
end