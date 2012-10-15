module AlPapi

  class Locales

    ##
    #
    # Get supported locales for specified engine.
    # @param engine [String] Defaults to google. Returns Partner API supported locales for engine or not supported message.

    def self.supported(engine = 'google')
      AlPapi.http.get "/supported/#{engine}"
    end

    ##
    #
    # Get further metadata on a specific locale for an engine.
    # @param engine [String] Defaults to google.
    # @param locale [String] Defaults to en-us.

    def self.description(engine = 'google', locale = 'en-us')
      AlPapi.http.get "/supported/#{engine}/#{locale.downcase}"
    end

  end

end
