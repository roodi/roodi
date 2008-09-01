require 'java'
require 'roodi'
require 'yaml'

include_class 'org.jruby.Ruby'
include_class 'org.jruby.RubyInstanceConfig'

module Roodi
  module Core
    class Runner
      def initialize(*checks)
        @checks = checks.empty? ? load_checks : checks
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
  
      def print(filename, content)
        node = @runtime.parse(content, filename, nil, 0, false)
        node.accept(PrintingVisitor.new)
      end

      def print_content(content)
        print("dummy-file.rb", content)
      end
  
      def print_file(filename)
        print(filename, File.read(filename))
      end
  
      def errors
        all_errors = @checks.collect {|check| check.errors}
        all_errors.flatten
      end
      
      private
      
      def load_checks
        check_objects = []
        config_file = File.join(File.dirname(__FILE__), "..", "..", "..", "roodi.yml")
        check_config = YAML.load_file config_file
        checks = check_config["checks"]
        checks.each { |check| check_objects << eval("Roodi::Checks::#{check['name']}.new") }
        check_objects
      end
    end
  end
end
