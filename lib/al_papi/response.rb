module AlPapi
  class Response
    attr_reader :success, :body, :errors, :code, :path, :params, :over_limit, :suspeneded

    ##
    # Initializing response object to be returned from API calls, used internally.
    #
    # @private

    def initialize(http, code, path, params) # @private
      @success, @body, @errors = http.success, http.response, http.errors
      @over_limit, @suspended  = http.over_limit, http.suspended
      @code, @path, @params    = code, path, params
    end

    ##
    #
    # Convenience method to determine if request was successfull or not
    # @return [Boolean]

    def success?
      @success ? true : false
    end

    ##
    #
    # Convenience method to see if you have reached your hourly limit
    # @return [Boolean]

    def over_limit?
      @over_limit ? true : false
    end

    ##
    #
    # Convenience method to see if your account is supended
    # @return [Boolean]

    def suspended?
      @suspended ? true : false
    end

    ##
    #
    # Parses JSON body of request and returns a Hashie::Mash
    # @return [Hashie::Mash]

    def parsed_body
      hash = JSON.parse(@body)
      Hashie::Mash.new hash
    rescue
      {}
    end
  end
end
