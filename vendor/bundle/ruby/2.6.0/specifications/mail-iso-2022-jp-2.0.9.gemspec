# -*- encoding: utf-8 -*-
# stub: mail-iso-2022-jp 2.0.9 ruby lib

Gem::Specification.new do |s|
  s.name = "mail-iso-2022-jp".freeze
  s.version = "2.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kohei MATSUSHITA".freeze, "Tsutomu KURODA".freeze]
  s.date = "2019-09-04"
  s.description = "A set of patches for mikel's mail gem. With this, you can easily send and receive mails with ISO-2022-JP enconding (so-called 'JIS-CODE').".freeze
  s.email = "hermes@oiax.jp".freeze
  s.homepage = "https://github.com/kuroda/mail-iso-2022-jp".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A set of patches that provides 'mail' gem with iso-2022-jp conversion capability.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mail>.freeze, [">= 2.2.6", "<= 2.7.1"])
      s.add_development_dependency(%q<actionmailer>.freeze, [">= 3.0.0", "< 7.0"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 3.12", "< 5.0"])
    else
      s.add_dependency(%q<mail>.freeze, [">= 2.2.6", "<= 2.7.1"])
      s.add_dependency(%q<actionmailer>.freeze, [">= 3.0.0", "< 7.0"])
      s.add_dependency(%q<rdoc>.freeze, [">= 3.12", "< 5.0"])
    end
  else
    s.add_dependency(%q<mail>.freeze, [">= 2.2.6", "<= 2.7.1"])
    s.add_dependency(%q<actionmailer>.freeze, [">= 3.0.0", "< 7.0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 3.12", "< 5.0"])
  end
end
