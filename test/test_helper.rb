require 'simplecov'
require 'webmock/rspec'

SimpleCov.start do
  add_filter '/test/'
  add_filter '/vendor/'
end

project_root = File.expand_path(File.dirname(__FILE__) + '/..')
$LOAD_PATH << "#{project_root}/lib"

require 'rubygems'
require 'al_papi'
require 'vcr'
require 'pry'

Dir[("#{project_root}/test/support/**/*.rb")].each { |f| require f }

require 'test/unit'

class Test::Unit::TestCase
  setup do
    AlPapi.configure do |c|
      c.api_key = TEST_KEY
    end
  end
end

VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir     = 'test/support'
  config.ignore_localhost         = true
  config.default_cassette_options = { record: :none }
end
