$: << File.join(File.dirname(__FILE__), 'lib')

require 'rake'
require 'spec/rake/spectask'
require 'roodi'
require 'checks/class_name_check'
require 'checks/empty_rescue_body_check'
require 'checks/for_loop_check'
require 'checks/magic_number_check'
require 'checks/method_name_check'
require 'checks/method_line_count_check'

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
  roodi = Roodi.new(ClassNameCheck.new, 
                    EmptyRescueBodyCheck.new,
                    ForLoopCheck.new,
                    # MagicNumberCheck.new,
                    MethodNameCheck.new, 
                    MethodLineCountCheck.new)
  ruby_files.each { |file| roodi.check_file(file) }
  roodi.errors.each {|error| puts error}
  puts "\nFound #{roodi.errors.size} errors."
end