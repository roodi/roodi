require 'java'
require 'checking_visitor'
require 'iterator_visitor'

include_class 'org.jruby.Ruby'
include_class 'org.jruby.RubyInstanceConfig'

class Roodi
  def initialize(*checks)
    @checks = checks
    @runtime = Ruby.newInstance(RubyInstanceConfig.new)
    checking_visitor = CheckingVisitor.new
    checking_visitor.checks = @checks
    @iterator_visitor = IteratorVisitor.new(checking_visitor)
  end

  def check(filename, content)
    node = @runtime.parse(content, filename, nil, 0, false)
    node.accept(@iterator_visitor)
  end

  def check_content(content)
    check("dummy-file.rb", content)
  end
  
  def check_file(filename)
    check(filename, File.read(filename))
  end
  
  def errors
    all_errors = @checks.collect {|check| check.errors}
    all_errors.flatten
  end
end