require 'java'
include_class 'org.jruby.ast.visitor.AbstractVisitor'

class CheckingVisitor < AbstractVisitor
  def checks=(checks)    
    @checks = checks
  end

  def visitNode(node)
    @checks.each {|check| check.evaluate(node)}
    nil
  end
end