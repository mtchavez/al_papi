Gem::Specification.new do |s|
  s.name             = 'al_papi'
  s.version          = '0.0.13'
  s.date             = '2012-01-04'
  s.summary          = "AuthorityLabs Partner API Wrapper"
  s.description      = "Wraps AuthorityLabs Partner API calls in a gem."
  s.authors          = ['Chavez']
  s.email            = ''
  s.files            = ['lib/al_papi.rb', 'lib/al_papi/config.rb', 'lib/al_papi/engines.rb', 'lib/al_papi/http.rb', 'lib/al_papi/locales.rb', 'lib/al_papi/request_error.rb', 'lib/al_papi/request.rb', 'lib/al_papi/response.rb']
  s.require_paths    = ['lib']
  s.homepage         = 'http://github.com/mtchavez/al_papi'
  s.rdoc_options     = ['--charset=UTF-8 --main=README.md']
  s.extra_rdoc_files = ['README.md']

  s.add_dependency(%q<rest-client>, ['>= 1.6.7'])
  s.add_dependency(%q<rspec>, ['>= 2.0'])
end
