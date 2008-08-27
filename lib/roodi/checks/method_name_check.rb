require 'java'
require 'roodi/checks/check'
include_class 'org.jruby.ast.DefnNode'

class MethodNameCheck < Check
  def interesting_nodes
    [DefnNode]
  end

  def evaluate(node)
    pattern = /^[a-z_?=]*$/
    add_error "#{position(node)} - Method name \"#{node.getName}\" should match pattern #{pattern}." unless node.getName =~ pattern
  end
end