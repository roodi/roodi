require 'rake/tasklib'
require 'roodi'

class RoodiTask < Rake::TaskLib
  attr_accessor :name
  attr_accessor :patterns
  attr_accessor :config
  attr_accessor :verbose

  def initialize name = :roodi, patterns = nil, config = nil
    @name      = name
    @patterns  = patterns || []
    @config    = config
    @verbose   = Rake.application.options.trace

    yield self if block_given?

    define
  end

  def define
    desc "Run Roodi against all source files"
    task name do
      puts "\nRunning Roodi checks"

      runner = Roodi::Core::Runner.new

      runner.config = config if config

      runner.start(@patterns)

      output_result(runner.errors, runner.files_checked)
    end
    self
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
end
