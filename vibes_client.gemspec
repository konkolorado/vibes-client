# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "vibes_client"
  s.version = "0.0.0"
  s.summary = "Vibes Client"
  s.description = "A simple gem for the Vibes API"
  s.authors = ["konkolorado"]
  s.email = "konkolorado@github.com"
  s.homepage =
    "https://rubygems.org/gems/hola"
  s.license = "Apache-2.0"
  s.required_ruby_version = Gem::Requirement.new(">= 3.0.0")
  s.executables << "vbc"
  s.files = Dir["lib/**/*.rb"] + Dir["bin/*"]
end
