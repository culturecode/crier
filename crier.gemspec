$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "crier/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "crier"
  s.version     = Crier::VERSION
  s.authors     = ["Ryan Wallace", "Nicholas Jakobsen"]
  s.email       = ["contact@culturecode.ca"]
  s.summary     = "Simple notification for the whole town"
  s.description = "Simple notification for the whole town"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", [">= 5", "< 8"]

  s.add_development_dependency('bundler')
  s.add_development_dependency('sqlite3', '~> 1.4')
  s.add_development_dependency('rspec-rails', '~> 4')
end
