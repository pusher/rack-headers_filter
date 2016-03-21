# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "rack-headers_filter"
  spec.version       = '0.0.1'
  spec.authors       = ["zimbatm"]
  spec.email         = ["zimbatm@zimbatm.com"]

  spec.summary       = %q{Removes sensitive untrusted headers from the request}
  spec.description   = %q{
    The goal of this gem is to avoid depending on potentially forgeable
    headers down the line by configuring the deploy target properly.
  }
  spec.homepage      = "https://github.com/pusher/rack-headers_filter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rack", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
