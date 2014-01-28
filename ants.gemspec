# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ants/version'

Gem::Specification.new do |spec|
  spec.name          = "ants"
  spec.version       = Ants::VERSION
  spec.authors       = ["Simon van Dyk"]
  spec.email         = ["simon.vandyk@gmail.com"]
  spec.description   = %q{Small gem to illustrate how to use an ant algorithm to do data clustering.}
  spec.summary       = %q{This gem implements the minimal model for ant clustering by Deneubourg, but with heterogeneous items. The items are compared by calculating the similarity of a hash of interests.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 2.14"
end
