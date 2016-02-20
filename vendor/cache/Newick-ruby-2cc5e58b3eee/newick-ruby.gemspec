# -*- encoding: utf-8 -*-
# stub: newick-ruby 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "newick-ruby"
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jonathan Badger"]
  s.date = "2015-06-01"
  s.description = "newick-ruby provides routines for parsing newick-format phylogenetic trees."
  s.email = "jhbadger@gmail.com"
  s.executables = ["newickAlphabetize", "newickCompare", "newickDist", "newickDraw", "newickReorder", "newickReroot", "newickTaxa"]
  s.files = ["README", "bin/newickAlphabetize", "bin/newickCompare", "bin/newickDist", "bin/newickDraw", "bin/newickReorder", "bin/newickReroot", "bin/newickTaxa", "example/jgi_19094_1366.m000227-Phatr2.tree", "lib/Newick.rb", "test/tc_Newick.rb"]
  s.homepage = "http://github.com/jhbadger/Newick-ruby"
  s.rubygems_version = "2.4.8"
  s.summary = "newick-ruby provides routines for parsing newick-format phylogenetic trees."
  s.test_files = ["test/tc_Newick.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fpdf>, [">= 1.5.3"])
    else
      s.add_dependency(%q<fpdf>, [">= 1.5.3"])
    end
  else
    s.add_dependency(%q<fpdf>, [">= 1.5.3"])
  end
end
