#!/usr/bin/env jruby
$: << File.join(File.dirname(__FILE__), 'lib')

require 'java'
require 'checking_visitor'
require 'iterator_visitor'
require 'recursive_visitor'
require 'checks/class_name_check'
require 'checks/magic_number_check'
require 'checks/method_name_check'
require 'checks/method_line_count_check'

include_class 'org.jruby.Ruby'
include_class 'org.jruby.RubyInstanceConfig'
include_class 'org.jruby.ast.visitor.DefaultIteratorVisitor'
include_class 'org.jruby.ast.visitor.NodeVisitor'
include_class 'org.jruby.evaluator.Instruction'
include_class 'java.util.ArrayList'

@runtime = Ruby.newInstance(RubyInstanceConfig.new)
checking_visitor = CheckingVisitor.new
checking_visitor.checks = [MethodNameCheck.new, ClassNameCheck.new, MethodLineCountCheck.new, MagicNumberCheck.new]

@iterator_visitor = RecursiveVisitor.new
@iterator_visitor.visitor = checking_visitor

def check_file(filename)
  content = File.read(filename)
  node = @runtime.parse(content, filename, nil, 0, false)
  node.accept(@iterator_visitor)
end

def check_all_joodi_files
  ruby_files = File.join(File.dirname(__FILE__), "**", "*.rb")
  Dir.glob(ruby_files).each do |file|
    check_file(file)
  end
end

def check_sample_file
  # check_file("spec/sample-file.rb")
  check_file("roodi.rb")
end

# check_sample_file
check_all_joodi_files