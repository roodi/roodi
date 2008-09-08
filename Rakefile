$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'hoe'
require 'rake'
require 'spec/rake/spectask'
require 'roodi'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*spec.rb']
end

desc "Run Roodi against all source files"
task :roodi do
  pattern = File.join(File.dirname(__FILE__), "**", "*.rb")
  roodi(Dir.glob(pattern))
end

task :roodi_runway do
  pattern = File.join("/Users/marty/Data/runway", "**", "*.rb")
  roodi(Dir.glob(pattern))
end

def roodi(ruby_files)
  roodi = Roodi::Core::ParseTreeRunner.new
  ruby_files.each { |file| roodi.check_file(file) }
  roodi.errors.each {|error| puts error}
  puts "\nFound #{roodi.errors.size} errors."
end

Hoe.new('roodi', Roodi::VERSION) do |p|
  p.developer('Marty Andrews', 'marty@cogentconsulting.com.au')
  p.remote_rdoc_dir = '' # Release to root
end