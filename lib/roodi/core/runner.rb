require 'pp'
require 'yaml'

require 'roodi/core/checking_visitor'
require 'roodi/core/parser'
require 'roodi/core/visitable_sexp'

module Roodi
  module Core
    class Runner
      DEFAULT_CONFIG = "roodi.yml"

      attr_writer :config
      attr_reader :files_checked

      def initialize(*checks)
        @config = DEFAULT_CONFIG
        @checks = checks unless checks.empty?
      end

      def start(paths)
        puts "\nRunning Roodi checks"

        paths = ['.'] if paths == []
        all_files = collect_files(paths)
        @files_checked = all_files.count
        all_files.each do |path|
          check_file(path)
        end

        output_result(errors, @files_checked)
      end

      def output_result(errors, files_checked)
        errors.each {|error| puts "\e[31m#{error}\e[0m"}

        puts "\nChecked #{files_checked} files"
        result = "Found #{errors.size} errors."
        if errors.empty?
          puts "\e[32m#{result}\e[0m"
        else
          raise "\e[31m#{result}\e[0m"
        end
      end

      def collect_files(paths)
        files = []
        paths.each do |path|
          if File.file?(path)
            files << path
          elsif File.directory?(path)
            files += Dir.glob(File.join(path, '**/*.{rb,erb}'))
          else
            files += Dir.glob(path)
          end
        end
        files
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
