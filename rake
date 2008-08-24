#!/usr/bin/env jruby

require 'rubygems'

version = ">= 0"

if ARGV.first =~ /^_(.*)_$/ and Gem::Version.correct? $1 then
  version = $1
  ARGV.shift
end

gem 'rake', version
load 'rake'
