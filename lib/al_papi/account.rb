module AlPapi

  class Account

    ##
    # Details for your account including hourly POST/GET limits, current queue times and current balance.
    # Also includes any system messages posted about the API.
    #
    # @param account_id [String] *Required* - Your account ID in the Partner API

    def self.info(account_id)
      AlPapi.http.get "/account/#{account_id}"
    end

  end

end
