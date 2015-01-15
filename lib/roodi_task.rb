require 'rake/tasklib'
require 'roodi'

class RoodiTask < Rake::TaskLib
  attr_accessor :name
  attr_accessor :patterns
  attr_accessor :config
  attr_accessor :verbose

  def initialize(args = {})
    @name = args[:name] || :roodi
    @patterns = args[:patterns] || []
    @config = args[:config]
    @verbose = Rake.application.options.trace

    yield self if block_given?

    define
  end

  def define
    prevent_multiple_runs!

    desc "Run Roodi against all source files"
    task name do
      runner = Roodi::Core::Runner.new

      runner.config = config if config

      runner.start(@patterns)
    end
    self
  end

  private

  def prevent_multiple_runs!
    if Rake::Task.task_defined?(name)
      Rake::Task[name].clear
    end
  end
end

# Ensure that a default :roodi task is always available
RoodiTask.new
