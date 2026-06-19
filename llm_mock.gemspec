# frozen_string_literal: true

require_relative "lib/llm_mock/version"

Gem::Specification.new do |spec|
  spec.name = "llm_mock"
  spec.version = LlmMock::VERSION
  spec.authors = [ "Nate Brustein" ]
  spec.email = [ "nate@bidwrangler.com" ]

  spec.summary = "Shared contract for gems that fabricate LLM SDK response objects in tests."
  spec.description = <<~DESC
    The shared foundation for a family of gems (llm_mock_anthropic, and more) that
    build fake LLM SDK response objects for tests that stub the client directly.
    This gem defines the common provider contract those gems implement so tools
    like deja can drive any provider uniformly. You usually depend on a provider
    gem, not this one.
  DESC
  spec.homepage = "https://github.com/nbrustein/llm_mock"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir[ "lib/**/*.rb", "README.md", "CHANGELOG.md", "LICENSE" ]
  spec.require_paths = [ "lib" ]

  spec.add_development_dependency "rspec", "~> 3.0"
end
