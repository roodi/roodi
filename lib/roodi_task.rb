class RoodiTask < Rake::TaskLib
  attr_accessor :name
  attr_accessor :patterns
  attr_accessor :config
  attr_accessor :verbose

  def initialize name = :roodi, patterns = nil, config = nil
    @name      = name
    @patterns  = patterns || %w(app/**/*.rb lib/**/*.rb spec/**/*.rb test/**/*.rb)
    @config    = config
    @verbose   = Rake.application.options.trace

    yield self if block_given?

    define
  end

  def define
    desc "Check for design issues in: #{patterns.join(', ')}"
    task name do
      runner = Roodi::Core::Runner.new

      runner.config = config if config

      patterns.each do |pattern|
        Dir.glob(pattern).each { |file| runner.check_file(file) }
      end

      runner.errors.each {|error| puts error}

      raise "Found #{runner.errors.size} errors." unless runner.errors.empty?
    end
    self
  end
end
