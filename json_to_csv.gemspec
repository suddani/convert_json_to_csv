# frozen_string_literal: true

require_relative "lib/json_to_csv/version"

Gem::Specification.new do |spec|
  spec.name          = "json_to_csv"
  spec.version       = JsonToCsv::VERSION
  spec.authors       = ["Suddani"]
  spec.email         = ["suddani@googlemail.com"]

  spec.summary       = "Convert a stream of json objects to csv"
  spec.description   = "Convert a stream of json objects to csv"
  spec.homepage      = "https://github.com/suddani/json_to_csv"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/suddani/json_to_csv"
  spec.metadata["changelog_uri"] = "https://github.com/suddani/json_to_csv/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = ["json_to_csv"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
