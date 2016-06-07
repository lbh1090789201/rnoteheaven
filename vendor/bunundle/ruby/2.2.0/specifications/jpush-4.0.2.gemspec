# -*- encoding: utf-8 -*-
# stub: jpush 4.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "jpush"
  s.version = "4.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "TODO: Set to 'http://mygemserver.com'" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["JPush Offical"]
  s.bindir = "exe"
  s.date = "2016-04-29"
  s.description = "JPush's officially supported Ruby client library for accessing JPush APIs. \u{6781}\u{5149}\u{63a8}\u{9001}\u{5b98}\u{65b9}\u{652f}\u{6301}\u{7684} Ruby \u{7248}\u{672c}\u{670d}\u{52a1}\u{5668}\u{7aef} SDK. \u{76f8}\u{5e94}\u{7684} API \u{6587}\u{6863}\u{ff1a}http://docs.jpush.io/server/server_overview/ "
  s.email = ["support@jpush.cn"]
  s.homepage = "https://github.com/jpush/jpush-api-ruby-client"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2")
  s.rubygems_version = "2.4.8"
  s.summary = "JPush's officially supported Ruby client library for accessing JPush APIs."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.11"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>, ["~> 5.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.11"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<minitest>, ["~> 5.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.11"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<minitest>, ["~> 5.0"])
  end
end
