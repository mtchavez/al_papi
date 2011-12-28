module AlPapi

  class Request

    attr_accessor :response, :success, :errors
    attr_reader   :config
    
    ##
    # 
    # [config]  * Hash { auth_key: 'your_auth_token' }
    #           * OR AlPapi::Config

    def initialize(config)
      @config  = config.is_a?(AlPapi::Config) ? config : Config.new(config)
      @success, @errors = false, []
    end
    
    def http # :nodoc:
      Http.new(self)
    end
    
    ##
    # == Params
    #
    # [keyword]     <b>Required</b> - 
    #               Your keyword you want to get results for
    # [engine]      <em>Optional</em> - 
    #               Defaults to google. Allowed engines are google, yahoo, bing.
    # [locale]      <em>Optional</em> - 
    #               Defaults to en-us. See AlPapi::Locales for supported locales.
    # [pages_from]  <em>Optional</em> - 
    #               Default is false. Google specific parameter to get results from
    #               the locale passed in when set to true.
    # [callback]    <em>Optional</em> - 
    #               Default is set on your account through the website. 
    #               Set specific callbacks here for each request. Callback a url that
    #               is sent a POST when results are returned.

    def post(params = {}, priority = false)
      path = priority ? '/keywords/priority' : '/keyword'
      http.post path, params
    end
    
    ##
    # == Params
    #
    # See post for required params
    
    def priority_post(params = {})
      post params, true
    end

    ##
    # == Params
    #
    # Parameters should be the same as what was posted to the Partner API where applies.
    #
    # [keyword]     <b>Required</b> - 
    #               The keyword you are ready to get results for.
    # [engine]      <em>Optional</em> - 
    #               Defaults to google. Allowed engines are google, yahoo, bing.
    # [locale]      <em>Optional</em> - 
    #               Defaults to en-us. See AlPapi::Locales for supported locales.
    # [rank_date]   <em>Optional</em> - 
    #               Default is set to today UTC time.
    #               Date should be in format of YYYY-MM-DD ie. 2011-12-28
    # [data_format] <em>Optional</em> - 
    #               Default is JSON. Options are HTML or JSON.

    def get(params = {})
      http.get '/keywords/get', params
    end

    ##
    #
    # Convenience method to determine if request was successfull or not

    def success?
      return @success
    end

  end
  
end
