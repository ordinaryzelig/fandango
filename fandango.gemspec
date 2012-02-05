# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fandango/version"

Gem::Specification.new do |s|
  s.name        = "fandango"
  s.version     = Fandango::VERSION
  s.authors     = ["Jared Ning"]
  s.email       = ["jared@redningja.com"]
  s.homepage    = "https://github.com/ordinaryzelig/fandango"
  s.summary     = "Fandango API"
  s.description = "Find theaters and movies on sale near a given postal code"

  s.rubyforge_project = "fandango"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'activesupport', '>= 3.0.8', '< 3.2.0'
  # Feedzirra 0.1.1 lists builder ~= 2.1.2,
  # but it works with builder >= 2.1.2.
  # ActiveSupport 3 depends on builder 3.
  # So we have to make a local copy of feedzirra until a newer gem is released.
  # And we have to include dependencies manually.
  # See https://github.com/pauldix/feedzirra/issues/77.
  # s.add_runtime_dependency 'feedzirra', '0.1.2'

  # Following dependencies copied from feedzirra's gemspec.
  s.add_runtime_dependency 'nokogiri',      ['>= 1.4.4']
  s.add_runtime_dependency 'sax-machine',   ['~> 0.1.0']
  s.add_runtime_dependency 'curb',          ['~> 0.7.15']
  s.add_runtime_dependency 'builder',       ['>= 2.1.2']
  s.add_runtime_dependency 'activesupport', ['>= 3.0.8']
  s.add_runtime_dependency 'loofah',        ['~> 1.2.0']
  s.add_runtime_dependency 'rdoc',          ['~> 3.8']
  s.add_runtime_dependency 'rake',          ['>= 0.8.7']
  s.add_runtime_dependency 'i18n',          ['>= 0.5.0']

  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'mocha', '0.10.3'
  s.add_development_dependency 'minitest', '2.11.1'
end
