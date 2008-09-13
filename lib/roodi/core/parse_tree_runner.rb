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
      
      attr_writer :config
      
      def initialize(*checks)
        @config = DEFAULT_CONFIG
        @checks = checks unless checks.empty?
        @parser = Parser.new
      end
      
      def check(filename, content)
        @checks ||= load_checks
        node = parse(filename, content)
        node.accept(IteratorVisitor.new(CheckingVisitor.new(@checks))) if node
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
      
      def parse(filename, content)
        begin
          @parser.parse(content, filename)
        rescue Exception => e
          puts "#{filename} looks like it's not a valid Ruby file.  Skipping..." if ENV["ROODI_DEBUG"]
          nil
        end
      end

      def load_checks
        check_objects = []
        checks = YAML.load_file @config
        checks.each do |check| 
          klass = eval("Roodi::Checks::#{check[0]}")
          check_objects << (check[1].empty? ? klass.new : klass.new(check[1]))
        end
        check_objects
      end
    end
  end
end
