# frozen_string_literal: true

require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
end

desc "Run tests"
task default: :test

task bi: :build_and_install

desc "Build and install the gem locally"
task :build_and_install do
  # Get the gem name and version from the gemspec
  gemspec = Dir["*.gemspec"].first
  if gemspec.nil?
    puts "No gemspec file found!"
    exit 1
  end

  gem_name = File.basename(gemspec, ".gemspec")

  # Load the gemspec to get the version
  spec = Gem::Specification.load(gemspec)
  version = spec.version.to_s

  # Build the gem
  sh "RUBYOPT=-W0 gem build #{gemspec}", verbose: false

  # Install the gem locally
  gem_file = "#{gem_name}-#{version}.gem"
  sh "RUBYOPT=-W0 gem install #{gem_file}", verbose: false

  # Remove the build artifact
  sh "rm #{gem_file}", verbose: false
end
