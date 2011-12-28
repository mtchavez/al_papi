module AlPapi

  class Response

    attr_reader :success, :body, :errors, :code, :path, :params

    def initialize(http, _code, _path, _params) # :nodoc:
      @success, @body, @errors = http.success, http.response, http.errors
      @code, @path, @params    = _code, _path, _params
    end
    
    ##
    #
    # Convenience method to determine if request was successfull or not

    def success?
      return @success
    end

  end

end
