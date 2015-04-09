# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uat/consul/version'

Gem::Specification.new do |spec|
  spec.name          = "uat-consul"
  spec.version       = UAT::Consul::VERSION
  spec.authors       = ["Tommy Sullivan", "Blaine Schanfeldt"]
  spec.email         = ["thomas.sullivan@lookout.com", "blaine.schanfeldt@lookout.com"]

  spec.summary       = "helper for consul / service discovery during testing"
  spec.homepage      = "https://github.com/lookout/uat"
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'simplecov', '~> 0.9.2'
  spec.add_development_dependency 'ipaddress', '~> 0.8.0'
  spec.add_development_dependency 'yard', '~> 0.8.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'webmock', '~> 1.21.0'

  spec.add_dependency 'diplomat', '~> 0.5.1'
end
