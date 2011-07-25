# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "swf_train/version"

Gem::Specification.new do |s|
  s.name        = "swf_train"
  s.version     = SwfTrain::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Zeke Sikelianos"]
  s.email       = ["zeke@sikelianos.com"]
  s.homepage    = "https://github.com/zeke/swf_train"
  s.summary     = %q{A simple and flexible Rails helper for embedding SWFs in your views.}

  s.rubyforge_project = "swf_train"

  s.add_dependency 'rails'
  s.add_dependency 'rake'
  
  s.add_development_dependency 'rspec'
  
  # Optional..
  s.add_development_dependency 'autotest'  
  s.add_development_dependency 'autotest-rails-pure'
  s.add_development_dependency 'autotest-growl'
  s.add_development_dependency 'autotest-fsevent'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end