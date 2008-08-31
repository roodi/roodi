PKG_FILES = %w(CHANGELOG LICENSE README Rakefile) + Dir.glob("{bin,doc,lib,spec}/**/*")
RDOC_OPTS = ['--quiet', '--title', 'The Roodi Reference', '--main', 'README', '--inline-source']
      
Gem::Specification.new do |s|
  s.name             = "roodi"
  s.version          = "0.1.0"
  s.platform         = "jruby"
  s.summary          = "Ruby Object Oriented Design Inferometer"
  s.email            = "marty@martyandrews.net"
  s.homepage         = "https://github.com/martinjandrews/roodi"
  s.description      = "Roodi parses your Ruby code and warns you about design issues you have based on the checks that is has configured."
  s.has_rdoc         = true
  s.author           = "Marty Andrews"
  s.files            = PKG_FILES
  s.test_files       = Dir.glob("spec/**/*")
  s.rdoc_options     = RDOC_OPTS
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README"]
end
