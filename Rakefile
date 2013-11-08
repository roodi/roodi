require 'rake'
require 'rspec/core/rake_task'
require 'bundler'
require 'roodi'
require 'bundler/gem_tasks'

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec)

desc "Run Roodi against all source files"
task :roodi do
  runner = Roodi::Core::Runner.new
  puts "\nRunning Roodi checks"

  runner.start([])
  runner.errors.each {|error| puts error}

  puts "\nChecked #{runner.files_checked} files"
  puts "Found #{runner.errors.size} errors"
end

task :default => [:spec, :roodi]
