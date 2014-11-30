module AlPapi

  class Http # @private

    attr_accessor :errors, :response, :success, :config, :over_limit, :suspended

    def initialize(_config)
      @config, @errors, @success, @over_limit, @suspended = _config, [], false, false, false
    end

    def get(path, params = {})
      request 'get', "#{path}?#{RestClient::Payload.generate(build_params(params))}"
    end

    def post(path, params = {})
      request 'post', path, build_params(params)
    end

    def build_params(params = {})
      params.merge(:auth_token => @config.api_key, :format => 'json')
    end

    def request(http_verb, path, params = nil)
      url  = "#{@config.host}#{path}"
      args = [http_verb, url]
      args << params if http_verb == 'post'

      RestClient.send(*args) do |res|
        body = res.body
        code = res.code.to_i

        self.response = body
        self.errors   = []

        case code
        when 200
          begin
            JSON.parse body
          rescue JSON::ParserError
            self.response = body
          end
          self.success = true
        when 204
          self.errors << RequestError.new('No Content', code, path, params)
        when 401
          self.errors << RequestError.new('Invalid Auth Token Provided', code, path, params)
        when 403
          if body.match(/Account Suspended/i)
            self.suspended = true
            self.errors << RequestError.new('Account Suspended', code, path, params)
          elsif body.match(/Request Limit Exceeded/i)
            self.over_limit = true
            self.errors << RequestError.new('Request Limit Exceeded', code, path, params)
          end
        else
          self.errors << RequestError.new(body, code, path, params)
        end

        Response.new(self, code, path, params)
      end
    end

  end

end
