#!/usr/bin/env rake
require 'bundler/setup'
require 'bundler/gem_tasks'
begin
  require 'spec/rake/spectask'
  desc "Run all specs in spec directory"
  Spec::Rake::SpecTask.new(:spec) do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
  end
rescue LoadError
  require 'rspec/core/rake_task'
  desc "Run all specs in spec directory"
  RSpec::Core::RakeTask.new(:spec)
end

require File.expand_path('lib/roodi',File.dirname(__FILE__))

def roodi(ruby_files)
  roodi = Roodi::Core::Runner.new
  ruby_files.each { |file| roodi.check_file(file) }
  roodi.errors.each {|error| puts error}
  puts "\nFound #{roodi.errors.size} errors."
end

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*spec.rb']
end

desc "Run Roodi against all source files"
task :roodi do
  pattern = File.join(File.dirname(__FILE__), "**", "*.rb")
  roodi(Dir.glob(pattern))
end

task :default => :spec
