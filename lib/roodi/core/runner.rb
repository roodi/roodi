require 'java'
require 'roodi'
require 'yaml'

include_class 'org.jruby.Ruby'
include_class 'org.jruby.RubyInstanceConfig'

module Roodi
  module Core
    class Runner
      DEFAULT_CONFIG = File.join(File.dirname(__FILE__), "..", "..", "..", "roodi.yml")
      
      def initialize(*checks)
        @config = DEFAULT_CONFIG
        @checks = checks unless checks.empty?
        @runtime = Ruby.newInstance(RubyInstanceConfig.new)
      end
      
      def config=(config)
        @config = config
        @checks = nil
      end
      
      def check(filename, content)
        @checks ||= load_checks
        node = @runtime.parse(content, filename, nil, 0, false)
        checking_visitor = CheckingVisitor.new
        checking_visitor.checks = @checks
        iterator_visitor = IteratorVisitor.new(checking_visitor)
        node.accept(iterator_visitor)
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
        check_config = YAML.load_file @config
        checks = check_config["checks"]
        checks.each { |check| check_objects << eval("Roodi::Checks::#{check['name']}.new") }
        check_objects
      end
    end
  end
end
