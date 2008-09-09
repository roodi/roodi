require 'pp'
require 'yaml'

require 'roodi/core/checking_visitor'
require 'roodi/core/iterator_visitor'
require 'roodi/core/parser'
require 'roodi/core/visitable_sexp'

module Roodi
  module Core
    class ParseTreeRunner
      DEFAULT_CONFIG = File.join(File.dirname(__FILE__), "..", "..", "..", "roodi.yml")
      
      def initialize(*checks)
        @config = DEFAULT_CONFIG
        @checks = checks unless checks.empty?
        @parser = Parser.new
      end
      
      def check(filename, content)
        @checks ||= load_checks
        begin
          node = @parser.parse(content, filename)
          node.accept(IteratorVisitor.new(CheckingVisitor.new(@checks)))
        rescue Exception
          puts "#{filename} looks like it's not a valid Ruby file.  Skipping..."
        end
      end

      def check_content(content)
        check("dummy-file.rb", content)
      end
  
      def check_file(filename)
        check(filename, File.read(filename))
      end
  
      def print(filename, content)
        node = @parser.parse(content, filename)
        pp node
      end

      def print_content(content)
        print("dummy-file.rb", content)
      end
  
      def print_file(filename)
        print(filename, File.read(filename))
      end
  
      def errors
        @checks ||= []
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
