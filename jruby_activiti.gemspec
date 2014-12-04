# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jruby_activiti/version'

Gem::Specification.new do |spec|
  spec.name          = "jruby_activiti"
  spec.version       = JrubyActiviti::VERSION
  spec.authors       = ["richfisher"]
  spec.email         = ["richfisher.pan@gmail.com"]
  spec.summary       = %q{Gem wrapper for Activiti BPM.}
  spec.description   = %q{Gem wrapper for Activiti BPM.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "jbundler"
  spec.add_development_dependency "minitest"

  spec.add_dependency "jbundler"
  spec.requirements << "jar 'org.activiti:activiti-engine', '>= 5.16'"
  spec.requirements << "jar 'org.slf4j:slf4j-log4j12', '>= 1.7'"
end
