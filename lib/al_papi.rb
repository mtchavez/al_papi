require 'json'
require 'rest-client'
require 'net/http'
require 'hashie'

require File.dirname(__FILE__) + '/al_papi/account'
require File.dirname(__FILE__) + '/al_papi/config'
require File.dirname(__FILE__) + '/al_papi/engines'
require File.dirname(__FILE__) + '/al_papi/http'
require File.dirname(__FILE__) + '/al_papi/keyword'
require File.dirname(__FILE__) + '/al_papi/locales'
require File.dirname(__FILE__) + '/al_papi/request_error'
require File.dirname(__FILE__) + '/al_papi/response'
require File.dirname(__FILE__) + '/al_papi/web_insight'

def ruby_19?
  RUBY_VERSION == '1.9.3'
end

module AlPapi
  module_function unless ruby_19?

  ##
  # @example Configure takes block to set API key to be used in API calls.
  #    AlPapi.configure do |config|
  #      config.api_key = 'my-key'
  #    end

  def configure
    yield config
  end
  module_function :configure if ruby_19?

  #
  # @return [AlPapi::Config]

  def config
    @config ||= Config.new
  end
  module_function :config if ruby_19?

  def http # @private
    Http.new(config)
  end
  module_function :http if ruby_19?
end
