require 'java'

include_class 'org.jruby.ast.ArgumentNode'
include_class 'org.jruby.ast.ListNode'
include_class 'org.jruby.ast.visitor.AbstractVisitor'

class RecursiveVisitor < AbstractVisitor
	def visitor=(visitor)
  	@visitor = visitor
	end

  def visitNode(node)
    if (node)
      node.accept(@visitor) unless node.class == ArgumentNode or node.class == ListNode
      children = node.childNodes
      children.each { |child| visitNode(child) } if children
    end
  end
end
