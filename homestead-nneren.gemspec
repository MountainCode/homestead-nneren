# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'homestead/nneren/version'

Gem::Specification.new do |spec|
  spec.name          = "homestead-nneren"
  spec.version       = Homestead::Nneren::VERSION
  spec.authors       = ["Chris Kentfield"]
  spec.email         = ["kentfieldc@orvis.com"]
  spec.description   = %q{NNEREN specific logic for Homestead}
  spec.summary       = %q{NNEREN specific logic for Homestead}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'ruby-rets', '~> 2.0.7'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
