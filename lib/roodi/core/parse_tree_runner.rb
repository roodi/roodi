require 'pp'
require 'roodi/core/checking_visitor'
require 'roodi/core/iterator_visitor'
require 'roodi/core/parser'
require 'roodi/core/visitable_sexp'

module Roodi
  module Core
    class ParseTreeRunner
      def initialize(*checks)
        @checks = checks
        @parser = Parser.new
      end
      
      def check(filename, content)
        node = @parser.parse(content, filename)
        node.accept(IteratorVisitor.new(CheckingVisitor.new(@checks)))
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
        all_errors = @checks.collect {|check| check.errors}
        all_errors.flatten
      end
    end
  end
end
