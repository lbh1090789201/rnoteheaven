# -*- encoding: utf-8 -*-
# stub: carrierwave-video 0.5.6 ruby lib

Gem::Specification.new do |s|
  s.name = "carrierwave-video"
  s.version = "0.5.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["rheaton"]
  s.date = "2014-05-16"
  s.description = "Transcodes to html5-friendly videos."
  s.email = ["rachelmheaton@gmail.com"]
  s.homepage = "https://github.com/rheaton/carrierwave-video"
  s.licenses = ["MIT"]
  s.requirements = ["ruby, version 1.9 or greater", "ffmpeg, version 0.11.1 or greater with libx256, libfaac, libtheora, libvorbid, libvpx enabled"]
  s.rubyforge_project = "carrierwave-video"
  s.rubygems_version = "2.4.8"
  s.summary = "Carrierwave extension that uses ffmpeg to transcode videos."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.10.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<streamio-ffmpeg>, [">= 0"])
      s.add_runtime_dependency(%q<carrierwave>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.10.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<streamio-ffmpeg>, [">= 0"])
      s.add_dependency(%q<carrierwave>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.10.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<streamio-ffmpeg>, [">= 0"])
    s.add_dependency(%q<carrierwave>, [">= 0"])
  end
end
