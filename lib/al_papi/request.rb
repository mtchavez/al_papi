module AlPapi

  class Request

    attr_accessor :response, :success, :errors
    attr_reader   :config

    def initialize(config)
      @config  = config.is_a?(AlPapi::Config) ? config : Config.new(config)
      @success, @errors = false, []
    end
    
    def http
      Http.new(self)
    end

    def post(params = {}, priority = false)
      path = priority ? '/keywords/priority' : '/keyword'
      http.post path, params
    end
    
    def priority_post(params = {})
      post params, true
    end

    def get(params = {})
      http.get '/keywords/get', params
    end

    def success?
      return @success
    end

  end
  
end
