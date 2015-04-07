# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uat/matchers/version'

Gem::Specification.new do |spec|
  spec.name          = "uat-matchers"
  spec.version       = UAT::Matchers::VERSION
  spec.authors       = ["Tommy Sullivan", "Blaine Schanfeldt"]
  spec.email         = ["thomas.sullivan@lookout.com", "blaine.schanfeldt@lookout.com"]

  spec.summary       = "A gem providing matchers that aid user acceptance testing"
  spec.homepage      = "https://github.com/lookout/uat"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
end
