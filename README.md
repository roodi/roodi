# roodi

[![Build Status](https://travis-ci.org/roodi/roodi.png?branch=master)](https://travis-ci.org/roodi/roodi)
[![Coverage Status](https://coveralls.io/repos/roodi/roodi/badge.png?branch=master)](https://coveralls.io/r/roodi/roodi?branch=master)

## Description

Roodi stands for Ruby Object Oriented Design Inferometer. It parses your Ruby code and warns you about design issues you have based on the checks that it has configured.

## Install

Open your terminal and type this:

`$ gem install roodi`

Alternatively, you can put it in your Gemfile:

`gem "roodi"`

## Synopsis

To check one or more files using the default configuration that comes with Roodi, use:

`$ roodi [-config=file] [pattern ...]`

## Example Usage

Check all ruby files recursively under the current directory:

`$ roodi` or `$ roodi .`

Check all ruby files in a rails app:

`$ roodi "rails_app/**/*.rb"`

Check one controller and one model file in a rails app:

`$ roodi app/controller/sample_controller.rb app/models/sample.rb`

Check one controller and all model files in a rails app:

`$ roodi app/controller/sample_controller.rb "app/models/*.rb"`

Check all ruby files in a rails app with a custom configuration file:

`$ roodi -config=my_roodi_config.yml "rails_app/**/*.rb"`

If you're writing a check, it is useful to see the structure of a file the way that Roodi tokenizes it (via ruby_parser). Use:

`$ roodi-describe [filename]`

## Running it as part of your build

Add the following to your Rakefile:

    require 'roodi_task'
    RoodiTask.new
    task :default => [:roodi]

## Custom Configuration

To change the set of checks included, or to change the default values of the checks, you can provide your own config file.  The config file is a YAML file that lists the checks to be included.  Each check can optionally include a hash of options that are passed to the check to configure it.  For example, the default config file looks like this:

    AssignmentInConditionalCheck:
    CaseMissingElseCheck:
    ClassLineCountCheck:
      line_count: 300
    ClassNameCheck:
      pattern: !ruby/regexp /^[A-Z][a-zA-Z0-9]*$/
    ClassVariableCheck:
    CyclomaticComplexityBlockCheck:
      complexity: 4
    CyclomaticComplexityMethodCheck:
      complexity: 8
    EmptyRescueBodyCheck:
    ForLoopCheck:
    MethodLineCountCheck:
      line_count: 20
    MethodNameCheck:
      pattern: !ruby/regexp /^[_a-z<>=\[|+-\/\*`]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/
    ModuleLineCountCheck:
      line_count: 300
    ModuleNameCheck:
      pattern: !ruby/regexp /^[A-Z][a-zA-Z0-9]*$/
    ParameterNumberCheck:
      parameter_count: 5

## Supported Checks

* AssignmentInConditionalCheck - Check for an assignment inside a conditional.  It's probably a mistaken equality comparison.
* CaseMissingElseCheck - Check that case statements have an else statement so that all cases are covered.
* ClassLineCountCheck - Check that the number of lines in a class is below the threshold.
* ClassNameCheck - Check that class names match convention.
* CyclomaticComplexityBlockCheck - Check that the cyclomatic complexity of all blocks is below the threshold.
* CyclomaticComplexityMethodCheck - Check that the cyclomatic complexity of all methods is below the threshold.
* EmptyRescueBodyCheck - Check that there are no empty rescue blocks.
* ForLoopCheck - Check that for loops aren't used (Use Enumerable.each instead)
* MethodLineCountCheck - Check that the number of lines in a method is below the threshold.
* MethodNameCheck - Check that method names match convention.
* ModuleLineCountCheck - Check that the number of lines in a module is below the threshold.
* ModuleNameCheck - Check that module names match convention.
* ParameterNumberCheck - Check that the number of parameters on a method is below the threshold.

## Suggested Checks

* BlockVariableShadowCheck - Check that a block variable does not have the same name as a method parameter or local variable.  It may be mistakenly referenced within the block.

## Contributing

### Bug reporting
Please use the GitHub issue tracker.

### Want to submit some code?
Fantastic! Please follow this procedure:
- Fork the repository
- Create a well-named topic branch
- Add specs for any changes you make
- Write meaningful commit messages explaining why this change is needed
- Create a pull request.

## License

(The MIT License)

Copyright (c) 2013 Peter Evjan

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
