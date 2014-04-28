module AlPapi

  class WebInsight

    ENDPOINT = '/web/insight'

    ##
    #
    # URL for the page you want insight into and the callback url you have implemented to know
    # when results are ready to get.
    #
    # @param url      [String] *Required* - The web page you want to gain insight on.
    # @param callback [String] *Required* - Default is the callback you have set for your account. Set specific callbacks per request by using this paramerter. A POST is sent to this callback URL when results are returned.
    # @raise [] When required parameter is not found.

    def self.post(params = {})
      check_params Hashie::Mash.new(params), *%w[url callback]
      request 'post', params
    end

    ##
    #
    # Parameters should be the same url as what was posted to the Partner API and the
    # date_created and time_created values passed back to you via the callback posted.
    #
    # @param url          [String] *Required* - The URL originally posted to Partner API
    # @param date_created [String] *Required* - The date_created that was returned in the callback.
    # @param time_created [String] *Required* - The time_created that was returned in the callback.

    def self.get(params = {})
      check_params Hashie::Mash.new(params), *%w[date_created time_created]
      request 'get', params
    end

  private

    ##
    #
    # Check if required params exist
    # @private

    def self.check_params(params, *param)
      param.each do |p|
        raise "#{p} parameter is required." if params[p].nil? || params[p.to_s].empty?
      end
    end

    def self.request(method, params = {})
      AlPapi.http.send method, ENDPOINT, params
    end

  end

end
