# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gendarme/version"

Gem::Specification.new do |s|
  s.name        = "gendarme"
  s.version     = Gendarme::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Franck Verrot"]
  s.email       = ["franck@verrot.fr"]
  s.homepage    = "https://github.com/cesario/gendarme"
  #0 Gendarmes have been during the implementation of that gem, I promise
  s.summary     = %q{Gendarme will bring order to chaos (well... that's the role of Gendarme ma bonne Dame...)}
  s.description = %q{Gendarme checks for preconditions and postrelations on the methods you want it to.}

  s.rubyforge_project = "gendarme"

  s.add_dependency 'activesupport'
  s.add_dependency 'i18n'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-core'
  s.add_development_dependency 'rspec-expectations'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
