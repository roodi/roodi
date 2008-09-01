Gem::Specification.new do |s|
  s.name             = "roodi"
  s.version          = "0.1.1"
  s.platform         = "jruby"
  s.summary          = "Ruby Object Oriented Design Inferometer"
  s.email            = "marty@martyandrews.net"
  s.homepage         = "https://github.com/martinjandrews/roodi"
  s.description      = "Roodi parses your Ruby code and warns you about design issues you have based on the checks that is has configured."
  s.has_rdoc         = true
  s.author           = "Marty Andrews"
  s.files            = ["CHANGELOG", "LICENSE", "README", "Rakefile", "bin/roodi", "bin/roodi-describe", "lib/roodi", "lib/roodi/checks", "lib/roodi/checks/check.rb", "lib/roodi/checks/class_name_check.rb", "lib/roodi/checks/cyclomatic_complexity_block_check.rb", "lib/roodi/checks/cyclomatic_complexity_check.rb", "lib/roodi/checks/cyclomatic_complexity_method_check.rb", "lib/roodi/checks/empty_rescue_body_check.rb", "lib/roodi/checks/for_loop_check.rb", "lib/roodi/checks/magic_number_check.rb", "lib/roodi/checks/method_line_count_check.rb", "lib/roodi/checks/method_name_check.rb", "lib/roodi/checks.rb", "lib/roodi/core", "lib/roodi/core/checking_visitor.rb", "lib/roodi/core/iterator_visitor.rb", "lib/roodi/core/printing_visitor.rb", "lib/roodi/core/runner.rb", "lib/roodi/core/tree_walker.rb", "lib/roodi/core.rb", "lib/roodi/jruby", "lib/roodi/jruby/ast", "lib/roodi/jruby/ast/node.rb", "lib/roodi/jruby/ast/when_node.rb", "lib/roodi/jruby/ast.rb", "lib/roodi/jruby.rb", "lib/roodi.rb", "lib/tasks", "spec/checks", "spec/checks/class_name_check_spec.rb", "spec/checks/cyclomatic_complexity_block_check_spec.rb", "spec/checks/cyclomatic_complexity_method_check_spec.rb", "spec/checks/empty_rescue_body_check_spec.rb", "spec/checks/for_loop_check_spec.rb", "spec/checks/magic_number_check_spec.rb", "spec/checks/method_line_count_check_spec.rb", "spec/checks/method_name_check_spec.rb", "spec/spec_helper.rb"]
  # s.test_files       = ["spec/checks", "spec/checks/class_name_check_spec.rb", "spec/checks/cyclomatic_complexity_block_check_spec.rb", "spec/checks/cyclomatic_complexity_method_check_spec.rb", "spec/checks/empty_rescue_body_check_spec.rb", "spec/checks/for_loop_check_spec.rb", "spec/checks/magic_number_check_spec.rb", "spec/checks/method_line_count_check_spec.rb", "spec/checks/method_name_check_spec.rb", "spec/spec_helper.rb"]
  s.rdoc_options     = ['--quiet', '--title', 'The Roodi Reference', '--main', 'README', '--inline-source']
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README"]
end
