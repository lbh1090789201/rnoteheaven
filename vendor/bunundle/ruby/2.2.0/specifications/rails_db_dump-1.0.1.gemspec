# -*- encoding: utf-8 -*-
# stub: rails_db_dump 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rails_db_dump"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Leonid Shevtsov"]
  s.date = "2015-06-19"
  s.description = "Adds a Rake command to dump and restore the application's database.\n\nDelegates to regular dumping utilities such as `mysqldump` and `pg_dump`. Unlike them, you *don't* have to remember any proper syntax.\n\nYou don't have to specify the connection parameters either; if the application works the dumper works, too.\n"
  s.email = ["leonid@shevtsov.me"]
  s.homepage = "https://github.com/leonid-shevtsov/rails_db_dump"
  s.rubygems_version = "2.4.8"
  s.summary = "Dump your Rails database with a simple rake task"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version
end
