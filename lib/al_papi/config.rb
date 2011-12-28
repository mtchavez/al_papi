module AlPapi

  class Config

    DEFAULT_HOST = 'http://api.authoritylabs.com'
    DEFAULT_PORT = 80

    class << self
      attr_writer :api_key, :host, :port
    end

    attr_reader :api_key, :host, :port
    
    def initialize(options = {})
      @api_key = options[:api_key]
      @host    = DEFAULT_HOST
      @port    = DEFAULT_PORT
    end
    
  end

end
