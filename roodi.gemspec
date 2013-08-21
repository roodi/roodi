$: << File.expand_path("../lib", __FILE__)
require "roodi/version"

Gem::Specification.new do |gem|

  gem.name = "roodi"
  gem.summary = "Roodi stands for Ruby Object Oriented Design Inferometer"
  gem.description = "Roodi parses your Ruby code and warns you about design issues you have based on the checks that is has configured"
  gem.homepage = "http://github.com/roodi/roodi"
  gem.authors = ["Marty Andrews", "Peter Evjan"]
  gem.email = "hello@peterevjan.com"
  gem.files = Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir['[A-Za-z]*'] + Dir['spec/**/*']
  gem.version = Roodi::VERSION.dup
  gem.platform = Gem::Platform::RUBY
  gem.add_runtime_dependency("ruby_parser", [">= 3.2.2", "~> 3.2"])
  gem.executables = ["roodi", "roodi-describe"]
  gem.files = `git ls-files`.split($\)
  gem.test_files =  gem.files.grep(%r{^(test|spec|features)/})
  gem.executables =  gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  gem.license = 'MIT'

end
