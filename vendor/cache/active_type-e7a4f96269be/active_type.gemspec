# -*- encoding: utf-8 -*-
# stub: active_type 0.4.5 ruby lib

Gem::Specification.new do |s|
  s.name = "active_type"
  s.version = "0.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Tobias Kraze", "Henning Koch"]
  s.date = "2016-03-06"
  s.description = "Make any Ruby object quack like ActiveRecord"
  s.email = "tobias.kraze@makandra.de"
  s.files = [".gitignore", ".ruby-version", ".travis.yml", "CHANGELOG.md", "LICENSE", "README.md", "Rakefile", "active_type.gemspec", "gemfiles/Gemfile.3.2.mysql2", "gemfiles/Gemfile.3.2.mysql2.lock", "gemfiles/Gemfile.3.2.sqlite3", "gemfiles/Gemfile.3.2.sqlite3.lock", "gemfiles/Gemfile.4.0.sqlite3", "gemfiles/Gemfile.4.0.sqlite3.lock", "gemfiles/Gemfile.4.1.sqlite3", "gemfiles/Gemfile.4.1.sqlite3.lock", "gemfiles/Gemfile.4.2.1.mysql2", "gemfiles/Gemfile.4.2.1.mysql2.lock", "gemfiles/Gemfile.4.2.1.pg", "gemfiles/Gemfile.4.2.1.pg.lock", "gemfiles/Gemfile.4.2.1.sqlite3", "gemfiles/Gemfile.4.2.1.sqlite3.lock", "lib/active_type.rb", "lib/active_type/extended_record.rb", "lib/active_type/extended_record/inheritance.rb", "lib/active_type/nested_attributes.rb", "lib/active_type/nested_attributes/association.rb", "lib/active_type/nested_attributes/builder.rb", "lib/active_type/nested_attributes/nests_many_association.rb", "lib/active_type/nested_attributes/nests_one_association.rb", "lib/active_type/no_table.rb", "lib/active_type/object.rb", "lib/active_type/record.rb", "lib/active_type/type_caster.rb", "lib/active_type/util.rb", "lib/active_type/version.rb", "lib/active_type/virtual_attributes.rb", "spec/active_type/extended_record/single_table_inheritance_spec.rb", "spec/active_type/extended_record_spec.rb", "spec/active_type/nested_attributes_spec.rb", "spec/active_type/object_spec.rb", "spec/active_type/record_spec.rb", "spec/active_type/util_spec.rb", "spec/integration/holidays_spec.rb", "spec/integration/shape_spec.rb", "spec/integration/sign_in_spec.rb", "spec/integration/sign_up_spec.rb", "spec/shared_examples/accessors.rb", "spec/shared_examples/belongs_to.rb", "spec/shared_examples/coercible_columns.rb", "spec/shared_examples/constructor.rb", "spec/shared_examples/defaults.rb", "spec/shared_examples/dirty_tracking.rb", "spec/shared_examples/dupable.rb", "spec/shared_examples/mass_assignment.rb", "spec/spec_helper.rb", "spec/support/database.rb", "spec/support/database.sample.yml", "spec/support/error_on.rb", "spec/support/i18n.rb", "spec/support/protected_params.rb", "spec/support/time_zone.rb"]
  s.homepage = "https://github.com/makandra/active_type"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Make any Ruby object quack like ActiveRecord"
  s.test_files = ["spec/active_type/extended_record/single_table_inheritance_spec.rb", "spec/active_type/extended_record_spec.rb", "spec/active_type/nested_attributes_spec.rb", "spec/active_type/object_spec.rb", "spec/active_type/record_spec.rb", "spec/active_type/util_spec.rb", "spec/integration/holidays_spec.rb", "spec/integration/shape_spec.rb", "spec/integration/sign_in_spec.rb", "spec/integration/sign_up_spec.rb", "spec/shared_examples/accessors.rb", "spec/shared_examples/belongs_to.rb", "spec/shared_examples/coercible_columns.rb", "spec/shared_examples/constructor.rb", "spec/shared_examples/defaults.rb", "spec/shared_examples/dirty_tracking.rb", "spec/shared_examples/dupable.rb", "spec/shared_examples/mass_assignment.rb", "spec/spec_helper.rb", "spec/support/database.rb", "spec/support/database.sample.yml", "spec/support/error_on.rb", "spec/support/i18n.rb", "spec/support/protected_params.rb", "spec/support/time_zone.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<activerecord>, [">= 3.2"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 3.2"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 3.2"])
  end
end
