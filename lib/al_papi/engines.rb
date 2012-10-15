module AlPapi

  class Engines

    ##
    # Supported engines for Partner API.
    #
    # @return [Array] Supported engines.

    def self.all
      %w[google bing yahoo]
    end

  end

end
