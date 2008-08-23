require 'java'
require 'checks/check'
include_class 'org.jruby.ast.DefnNode'

class MethodNameCheck < Check
  def interested_in?(node)
    node.class == DefnNode
  end

  def evaluate(node)
    if interested_in?(node)
      pattern = /^[a-z_?=]*$/
      puts "#{position(node)} - Method name \"#{node.getName}\" should match pattern #{pattern}." unless node.getName =~ pattern
    end
  end
end