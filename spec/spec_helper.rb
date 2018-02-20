require 'simplecov'
require 'webmock/rspec'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
end

require 'coveralls'
Coveralls.wear!

project_root = File.expand_path(File.dirname(__FILE__) + '/..')
$LOAD_PATH << "#{project_root}/lib"

require 'rubygems'
require 'al_papi'
require 'vcr'
require 'pry'

Dir[("#{project_root}/spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before do
    AlPapi.configure do |c|
      c.api_key = TEST_KEY
    end
  end

  config.raise_errors_for_deprecations!
end

VCR.configure do |config|
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.cassette_library_dir     = 'spec/support'
  config.ignore_localhost         = true
  config.default_cassette_options = { record: :none }
end
