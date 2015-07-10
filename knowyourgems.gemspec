# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knowyourgems/version'

Gem::Specification.new do |spec|
  spec.name          = "knowyourgems"
  spec.version       = Knowyourgems::VERSION
  spec.authors       = ["Karan Arora"]
  spec.email         = ["mail@arorakaran.com"]

  spec.summary       = %q{This gem helps you find out the history/details of gems you have written.}
  spec.description   = %q{This gem helps you find out the history/details of gems you have written.}
  spec.homepage      = "https://github.com/karanarora/knowyourgems/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
