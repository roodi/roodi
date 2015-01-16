require 'sexp'

class Sexp
  def accept(visitor)
    visitor.visit(self)
  end

  def node_type
    first
  end

  def children
    find_all { | sexp | Sexp === sexp }
  end

  def is_language_node?
    first.class == Symbol
  end

  def visitable_children
    parent = is_language_node? ? sexp_body : self
    parent.children
  end
end
