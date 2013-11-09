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

      runner.errors.each {|error| puts error}

      puts "\nChecked #{runner.files_checked} files"

      raise "Found #{runner.errors.size} errors." unless runner.errors.empty?
    end
    self
  end
end
