Gem::Specification.new do |s|
  s.name             = 'al_papi'
  s.version          = '1.0.3'
  s.date             = '2014-04-28'
  s.summary          = 'AuthorityLabs Partner API Wrapper'
  s.description      = 'Wraps AuthorityLabs Partner API calls in a gem.'
  s.authors          = ['Chavez']
  s.email            = ''
  s.files            = Dir.glob("{bin,lib}/**/*") + %w[README.md]
  s.require_paths    = ['lib']
  s.homepage         = 'http://github.com/mtchavez/al_papi'
  s.rdoc_options     = ['--charset=UTF-8 --main=README.md']
  s.extra_rdoc_files = ['README.md']

  # Gem Dependencies
  s.add_dependency 'hashie',      '~> 2.1.0', '>= 2.1.0'
  s.add_dependency 'rest-client', '~> 1.6.7', '>= 1.6.7'

  # Dev Dependencies
  s.add_development_dependency 'gemcutter', '~> 0.7.1',  '>= 0.7.1'
  s.add_development_dependency 'pry',       '~> 0.9.12', '>= 0.9.12.6'
  s.add_development_dependency 'rake',      '~> 10.1.0', '>= 10.1.0'
  s.add_development_dependency 'redcarpet', '~> 3.1.0',  '>= 3.1.0'
  s.add_development_dependency 'rspec',     '~> 2.14.1', '>= 2.14.1'
  s.add_development_dependency 'simplecov', '~> 0.8.2',  '>= 0.8.2'
  s.add_development_dependency 'vcr',       '~> 2.2.5',  '>= 2.2.5'
  s.add_development_dependency 'webmock',   '~> 1.8.11', '>= 1.8.11'
  s.add_development_dependency 'yard',      '~> 0.8.7',  '>= 0.8.7.4'
end
