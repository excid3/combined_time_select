# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "combined_time_select/version"

Gem::Specification.new do |s|
  s.name        = "combined_time_select"
  s.version     = CombinedTimeSelect::VERSION
  s.authors     = ["Chris Oliver"]
  s.email       = ["excid3@gmail.com"]
  s.homepage    = "https://github.com/excid3/combined_time_select"
  s.summary     = %q{A Rails time_select like Google Calendar with combined hour and minute time_select}
  s.description = %q{Generates a time_select field like Google calendar.}

  s.rubyforge_project = "combined_time_select"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "rails", ">= 5.0.0"
end
