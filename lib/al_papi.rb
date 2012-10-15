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

module AlPapi

  extend self

  def configure
    yield config
  end

  def config
    @config ||= Config.new
  end

  def http # @private
    Http.new(config)
  end

end
