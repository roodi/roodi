$: << File.join(File.dirname(__FILE__), 'lib')

require 'rake'
require 'spec/rake/spectask'
require 'roodi'
require 'checks/class_name_check'
require 'checks/magic_number_check'
require 'checks/method_name_check'
require 'checks/method_line_count_check'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*spec.rb']
end

desc "Run Roodi against all source files"
task :roodi do
  roodi = Roodi.new(MethodNameCheck.new, ClassNameCheck.new, MethodLineCountCheck.new, MagicNumberCheck.new)
  ruby_files = File.join(File.dirname(__FILE__), "**", "*.rb")
  Dir.glob(ruby_files).each do |file|
    errors = roodi.check_file(file)
    errors.each {|error| puts error}
  end
end