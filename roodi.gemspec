$: << File.expand_path("../lib", __FILE__)
require "roodi/version"

Gem::Specification.new do |gem|

  gem.name = "metric_fu-roodi"
  gem.summary = "Roodi stands for Ruby Object Oriented Design Inferometer"
  gem.description = "Roodi stands for Ruby Object Oriented Design Inferometer"
  gem.homepage = "http://roodi.rubyforge.org"
  gem.authors = ["Marty Andrews"]
  gem.email = "marty@cogent.co"

  gem.version = Roodi::VERSION.dup
  gem.platform = Gem::Platform::RUBY
  gem.add_runtime_dependency("ruby_parser")
  gem.homepage    = "http://github.com/metricfu/roodi"
  # TODO check if this is necessary
  # gem.required_ruby_version     = ">= 1.8.7"
  # gem.required_rubygems_version = ">= 1.3.6"
  gem.files              = `git ls-files`.split($\)
  gem.test_files         =  gem.files.grep(%r{^(test|spec|features)/})
  gem.executables        =  gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  gem.license     = 'MIT'

end
