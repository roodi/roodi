require 'pp'
require 'yaml'

require 'roodi/core/checking_visitor'
require 'roodi/core/parser'
require 'roodi/core/visitable_sexp'

module Roodi
  module Core
    class Runner
      DEFAULT_CONFIG = File.join(File.dirname(__FILE__), "..", "..", "..", "roodi.yml")

      attr_writer :config

      def initialize(*checks)
        @config = DEFAULT_CONFIG
        @checks = checks unless checks.empty?
      end

      def check(filename, content)
        @checks ||= load_checks
        @checker ||= CheckingVisitor.new(@checks)
        @checks.each {|check| check.start_file(filename)}
        node = parse(filename, content)
        node.accept(@checker) if node
        @checks.each {|check| check.end_file(filename)}
      end

      def check_content(content, filename = "dummy-file.rb")
        check(filename, content)
      end

      def check_file(filename)
        return unless File.exists?(filename)
        check(filename, File.read(filename))
      end

      def print(filename, content)
        node = parse(filename, content)
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
        all_errors.flatten + parsing_errors
      end

      private

      def parse(filename, content)
        begin
          Parser.new.parse(content, filename)
        rescue Exception
          parsing_errors << "#{filename} looks like it's not a valid Ruby file."
          nil
        end
      end

      def parsing_errors
        @parsing_errors ||= []
      end

      def load_checks
        check_objects = []
        checks = YAML.load_file @config
        checks.each do |check_class_name, options|
          check_class = Roodi::Checks.const_get(check_class_name)
          check_objects << check_class.make(options || {})
        end
        check_objects
      end

    end
  end
end
