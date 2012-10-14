module AlPapi

  class Account

    def self.info(account_id)
      AlPapi.http.get "/account/#{account_id}"
    end

  end

end
