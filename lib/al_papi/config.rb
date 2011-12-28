module AlPapi

  class Config

    DEFAULT_HOST = 'http://api.authoritylabs.com'
    DEFAULT_PORT = 80

    attr_accessor :api_key
    attr_reader   :host, :port

    ##
    #
    # == Options
    #
    # [auth_key]  Your Partner API api key. Required to make any API requests  

    def initialize(options = {})
      @api_key = options[:api_key]
      @host    = DEFAULT_HOST
      @port    = DEFAULT_PORT
    end
    
  end

end
