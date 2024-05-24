lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mock_ordway/version"

Gem::Specification.new do |spec|
  spec.name = "mock_ordway"
  spec.version = MockOrdway::VERSION
  spec.authors = ["Reid Takken"]
  spec.email = ["reid.takken@protrainings.com"]
  spec.summary = "A Ruby mocking library for Ordway"
  spec.description = "MockChargebee is a drop in mocking library for testing with Orway."
  spec.homepage = "https://github.com/rtakken/mock_ordway"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.2.2"

  spec.add_dependency "ordway-sdk"

  # s.add_runtime_dependency 'faraday', '~> 2.0'
  spec.add_runtime_dependency 'json', '~> 2.1', '>= 2.1.0'
  spec.add_runtime_dependency 'addressable', '~> 2.3', '>= 2.3.0'

  spec.add_development_dependency 'rspec', '~> 3.6', '>= 3.6.0'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.1'
  spec.add_development_dependency 'webmock', '~> 1.24', '>= 1.24.3'
  spec.add_development_dependency 'autotest', '~> 4.4', '>= 4.4.6'
  spec.add_development_dependency 'autotest-rails-pure', '~> 4.1', '>= 4.1.2'
  spec.add_development_dependency 'autotest-growl', '~> 0.2', '>= 0.2.16'
  spec.add_development_dependency 'autotest-fsevent', '~> 0.2', '>= 0.2.12'
end