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
      runner = Roodi::Core::Runner.new

      runner.config = config if config

      runner.start(@patterns)
    end
    self
  end
end
