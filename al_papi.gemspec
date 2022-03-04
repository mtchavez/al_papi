Gem::Specification.new do |s|
  s.name             = 'al_papi'
  s.version          = '1.0.5'
  s.date             = '2017-12-21'
  s.summary          = 'AuthorityLabs Partner API Wrapper'
  s.description      = 'Wraps AuthorityLabs Partner API calls in a gem.'
  s.authors          = ['Chavez']
  s.email            = ''
  s.files            = Dir.glob('{bin,lib}/**/*') + %w[README.md]
  s.require_paths    = ['lib']
  s.homepage         = 'http://github.com/mtchavez/al_papi'
  s.rdoc_options     = ['--charset=UTF-8 --main=README.md']
  s.extra_rdoc_files = ['README.md']

  # Gem Dependencies
  s.add_dependency 'hashie',      '~> 2.1.0', '>= 2.1.0'
  s.add_dependency 'rest-client', '~> 2.0.2', '>= 2.0.2'

  # Dev Dependencies
  s.add_development_dependency 'gemcutter', '~> 0.7.1', '>= 0.7.1'
  s.add_development_dependency 'pry',       '~> 0.10',  '>= 0.10.1'
  s.add_development_dependency 'rake',      '~> 10.4',  '>= 10.4.0'
  s.add_development_dependency 'redcarpet', '~> 3.2',   '>= 3.2.1'
  s.add_development_dependency 'test-unit', '~> 3.0',   '>= 3.0.0'
  s.add_development_dependency 'simplecov', '~> 0.9',   '>= 0.9.1'
  s.add_development_dependency 'vcr',       '~> 2.9',   '>= 2.9.3'
  s.add_development_dependency 'webmock',   '~> 2.3',   '>= 2.3.2'
  s.add_development_dependency 'yard',      '~> 0.9',   '>= 0.9.11'
end
