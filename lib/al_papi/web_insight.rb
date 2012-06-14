module AlPapi

  class WebInsight

    attr_reader   :config
    
    ##
    # 
    # [config]  * Hash { auth_key: 'your_auth_token' }
    #           * OR AlPapi::Config

    def initialize(config)
      @config  = config.is_a?(AlPapi::Config) ? config : Config.new(config)
      @success, @errors = false, []
    end
    
    def http # @private
      Http.new(@config)
    end
    
    ##
    # == Params
    #
    # URL for the page you want insight into and the callback url you have implemented to know
    # when results are ready to get.
    #
    # [url]         <b>Required</b> - 
    #               The web page you want to gain insight on.
    # [callback]    <em>Required</em> - 
    #               Default is set on your account through the website. 
    #               Set specific callbacks here for each request. Callback a url that
    #               is sent a POST when results are returned.

    def post(params = {}, priority = false)
      check_params Hashie::Mash.new(params), *%w[url callback]
      http.post '/web/insight', params
    end

    ##
    # == Params
    #
    # Parameters should be the same url as what was posted to the Partner API and the 
    # date_created and time_created values passed back to you via the callback posted.
    #
    # [url]            <b>Required</b> - 
    #                  The URL originally posted to Partner API
    # [date_created]   <em>Required</em> - 
    #                  The date_created that was returned in the callback.
    # [time_created]   <em>Required</em> - 
    #                  The time_created that was returned in the callback.

    def get(params = {})
      check_params Hashie::Mash.new(params), *%w[date_created time_created]
      http.get '/web/insight', params
    end

    def check_params(params, *param)
      param.each do |p|
        raise "#{p} parameter is required." if params[p].nil? || params[p.to_s].empty?
      end
    end

  end
  
end
