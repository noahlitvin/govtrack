# -*- encoding: utf-8 -*-
require File.expand_path('../lib/govtrack/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "govtrack"
  gem.version     = GovTrack::Gem::VERSION
  gem.authors     = ["Noah Litvin"]
  gem.email       = ["noah.litvin@gmail.com"]
  gem.homepage    = "https://github.com/noahlitvin/govtrack"
  gem.summary     = %q{A Ruby wrapper for the GovTrack API.}
  gem.description = %q{A Ruby wrapper for the GovTrack API.}

  gem.files = %w(CHANGELOG.md LICENSE.md README.md TODO.md govtrack.gemspec)
  gem.files += Dir.glob("lib/**/*.rb")
  gem.files += Dir.glob("spec/**/*")

  gem.test_files = Dir.glob("spec/**/*")
  
  gem.add_dependency 'httparty', ">= 0.6.1"

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb', "~> 1.3"
end