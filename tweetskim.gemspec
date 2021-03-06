# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tweetskim/version"

Gem::Specification.new do |s|
  s.name        = "tweetskim"
  s.version     = Tweetskim::VERSION
  s.authors     = ["Thomas Kjeldahl Nilsson"]
  s.email       = ["thomas@kjeldahlnilsson.net"]
  s.homepage    = "https://github.com/thomanil/tweetskim"
  s.summary     = %q{A stripped down CLI utility for reading tweets}
  s.description = %q{Usage: tweetskim [options]}

  s.rubyforge_project = "tweetskim"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "twitter"
  s.add_runtime_dependency "oauth"
  s.add_runtime_dependency "OptionParser"
  s.add_runtime_dependency "launchy"
  
  s.add_development_dependency "mocha"
end
