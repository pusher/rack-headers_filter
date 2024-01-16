# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "rack-headers_filter"
  spec.version       = "0.0.1"
  spec.authors       = ["zimbatm"]
  spec.email         = ["zimbatm@zimbatm.com"]

  spec.summary       = %q{Removes sensitive untrusted headers from the request}
  spec.description   = %q{
    The goal of this gem is to avoid depending on potentially forgeable
    headers down the line by configuring the deploy target properly.
  }
  spec.homepage      = "https://github.com/spinels/rack-headers_filter"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb", "script/*", "spec/**/*.rb"] + [
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "Rakefile",
    "README.md",
    "README.md",
  ]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7.8"
end
