require 'rake'
require 'rspec/core/rake_task'
require 'bundler'
require 'roodi'
require 'bundler/gem_tasks'
require 'roodi_task'

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec)

desc "Run Roodi against all source files"
RoodiTask.new

task :default => [:spec, :roodi]
