module AlPapi

  class Response

    attr_reader :success, :body, :errors, :code, :path, :params, :over_limit, :suspeneded

    def initialize(http, _code, _path, _params) # @private
      @success, @body, @errors = http.success, http.response, http.errors
      @over_limit, @suspended  = http.over_limit, http.suspended
      @code, @path, @params    = _code, _path, _params
    end
    
    ##
    #
    # Convenience method to determine if request was successfull or not

    def success?
      return @success
    end

    ##
    #
    # Convenience method to see if you have reached your hourly limit

    def over_limit?
      return @over_limit
    end

    ##
    #
    # Convenience method to see if your account is supended

    def suspended?
      return @suspended
    end

    def parsed_body
      hash = JSON.parse(@body) rescue {}
      Hashie::Mash.new hash
    end

  end

end
