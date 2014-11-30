module AlPapi

  ##
  #
  # Config class used internally.
  # Configure API calls using AlPapi.configure

  class Config

    DEFAULT_HOST = 'http://api.authoritylabs.com'
    DEFAULT_PORT = 80 # @private

    attr_accessor :api_key
    attr_reader   :host, :port # @private

    ##
    #
    # @private

    def initialize
      @host = DEFAULT_HOST
      @port = DEFAULT_PORT
    end

  end

end
