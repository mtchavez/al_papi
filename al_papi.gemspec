Gem::Specification.new do |s|
  s.name             = 'al_papi'
  s.version          = '1.0.1'
  s.date             = '2012-11-02'
  s.summary          = 'AuthorityLabs Partner API Wrapper'
  s.description      = 'Wraps AuthorityLabs Partner API calls in a gem.'
  s.authors          = ['Chavez']
  s.email            = ''
  s.files            = Dir.glob("{bin,lib}/**/*") + %w[README.md]
  s.require_paths    = ['lib']
  s.homepage         = 'http://github.com/mtchavez/al_papi'
  s.rdoc_options     = ['--charset=UTF-8 --main=README.md']
  s.extra_rdoc_files = ['README.md']

  s.add_dependency(%q<rest-client>, ['>= 1.6.7'])
  s.add_dependency(%q<hashie>, ['>= 1.2.0'])
  s.add_development_dependency(%q<rspec>, ['>= 2.0'])
  s.add_development_dependency(%q<simplecov>, ['>= 0.7.1'])
  s.add_development_dependency(%q<vcr>, ['>= 2.2.5'])
  s.add_development_dependency(%q<webmock>, ['>= 1.8.11'])
end
