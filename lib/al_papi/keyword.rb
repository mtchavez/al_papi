module AlPapi

  class Keyword
    
    ##
    #
    # POST a keyword/engine/locale combination to get SERP for.
    #
    # @param keyword    [String] *Required* - The keyword you are ready to get results for.
    # @param engine     [String] _Optional_ - Defaults to google
    # @param locale     [String] _Optional_ - Defaults to en-us. See {AlPapi::Locales} for supported locales.
    # @param pages_from [String] _Optional_ - Defaults is false. Google specific parameter to get results from locale passed in when set to true.
    # @param callback   [String] _Optional_ - Default is the callback you have set for your account. Set specific callbacks per request by using this paramerter. A POST is sent to this callback URL when results are returned.

    def self.post(params = {}, priority = false)
      path = priority ? '/keywords/priority' : '/keywords'
      AlPapi.http.post path, params
    end
    
    ##
    #
    # See post method {AlPapi::Keyword.post} for required params
    
    def self.priority_post(params = {})
      post params, true
    end

    ##
    #
    # Get SERP results for keyword already POSTed or in Partner API already.
    # See parameters for what can be passed in.
    #
    # @param keyword     [String] *Required* - The keyword you are ready to get results for.
    # @param engine      [String] _Optional_ - Defaults to google
    # @param locale      [String] _Optional_ - Defaults to en-us. See {AlPapi::Locales} for supported locales.
    # @param rank_date   [String] _Optional_ - Defaults to today UTC time. Format of YYY-MM-DD ie. 2011-12-28
    # @param data_format [String] _Optional_ - Default is JSON. If you want raw html pass "html" in for data_format

    def self.get(params = {})
      AlPapi.http.get '/keywords/get', params
    end

  end
  
end
