module AlPapi

  class Keyword
    
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

    def self.post(params = {}, priority = false)
      path = priority ? '/keywords/priority' : '/keywords'
      AlPapi.http.post path, params
    end
    
    ##
    # == Params
    #
    # See post method {AlPapi::Keyword.post} for required params
    
    def self.priority_post(params = {})
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

    def self.get(params = {})
      AlPapi.http.get '/keywords/get', params
    end

  end
  
end
