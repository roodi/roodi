require 'rake'
require 'rspec/core/rake_task'
require 'bundler'
require 'roodi'
require 'bundler/gem_tasks'

def roodi(ruby_files)
  roodi = Roodi::Core::Runner.new
  ruby_files.each { |file| roodi.check_file(file) }
  roodi.errors.each {|error| puts error}
  puts "\nFound #{roodi.errors.size} errors."
end

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec)

desc "Run Roodi against all source files"
task :roodi do
  pattern = File.join(File.dirname(__FILE__), "**", "*.rb")
  roodi(Dir.glob(pattern))
end

task :default => [:spec, :roodi]
