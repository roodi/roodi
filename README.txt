= roodi

* http://www.rubyforge.org/

== DESCRIPTION:

Roodi stands for Ruby Object Oriented Design Inferometer.  It parses your Ruby code and warns you about design issues you have based on the checks that is has configured.

== SUPPORTED CHECKS

* ClassNameCheck - Check that class names match convention.
* CyclomaticComplexityBlockCheck - Check that the cyclomatic complexity of all blocks is below the threshold.
* CyclomaticComplexityMethodCheck - Check that the cyclomatic complexity of all methods is below the threshold.
* EmptyRescueBodyCheck - Check that there are no empty rescue blocks.
* ForLoopCheck - Check that for loops aren't used (Use Enumerable.each instead)
* MethodNameCheck - Check that method names match convention.

== SYNOPSIS:

* TBD.  See the Rakefile in this project for an example of how to get started if you're on the bleeding edge.

== INSTALL:

* sudo gem install roodi

== LICENSE:

(The MIT License)

Copyright (c) 2008 Marty Andrews

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



== Introduction

Roodi is an acronym that stands for Ruby Object Oriented Design Inferometer.  It parses your Ruby code and warns you about design issues you have based on the checks that is has configured.

== Usage

TBD.  See the Rakefile in this project for an example of how to get started if you're on the bleeding edge.

== Background

Roodi is almost identical in design to the Java tool called Checkstyle (http://checkstyle.sf.net/), however it is named after the Java tool that I worked on called Joodi (http://joodi.checkstyle.net).  I think it's more appropriate to name it similarly to Joodi than Checkstyle, because the checks exist to warn you about design issues, not style issues.  Joodi has a different design, but a better name.  I used a combination of each.

== Design

Roodi builds an Abstract Syntax Tree (AST) of the Ruby source code, then uses the visitor patten to walk every node in the tree and see if the checks can infer any design issues with them.  Usually, the existence of an AST would mean running a grammar file through a parser to build it.  No such grammar file exists to build a complete representation of the source (including whitespace characters and comments) for the Ruby language, so I originally used the object model built by the JRuby team instead.  That design soon switched to use ParseTree instead, which makes Roodi more portable (it doesn't depend on JRuby anymore), but slightly less functional (mainly because ParseTree doesn't support line numbers).

== Checks currently supported
	ClassNameCheck					Check that class names match convention.
	CyclomaticComplexityBlockCheck	Check that the cyclomatic complexity of all blocks is below the threshold.
	CyclomaticComplexityMethodCheck	Check that the cyclomatic complexity of all methods is below the threshold.
	EmptyRescueBodyCheck			Check that there are no empty rescue blocks.
	ForLoopCheck					Check that for loops aren't used (Use Enumerable.each instead)
	MethodNameCheck					Check that method names match convention.
