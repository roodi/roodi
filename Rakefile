require 'rake'
require 'spec/rake/spectask'
require 'bundler'
require 'roodi'

Bundler::GemHelper.install_tasks

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
