Gem::Specification.new do |s|
  s.name        = 'al_papi'
  s.version     = '0.0.3'
  s.date        = '2011-12-26'
  s.summary     = "AuthorityLabs Partner API Wrapper"
  s.description = "Wraps AuthorityLabs Partner API calls in a gem."
  s.authors     = ["Chavez"]
  s.email       = ''
  s.files       = ['lib/al_papi.rb']
  s.require_paths = ['lib']
  s.homepage    = 'http://github.com/mtchavez/al_papi'
  s.add_dependency(%q<rest-client>, [">= 1.6.7"])
  s.add_dependency(%q<rspec>, [">= 0"])
end
