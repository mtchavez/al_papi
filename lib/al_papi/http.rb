module AlPapi
  class Http # @private
    HANDLED_CODES = [200, 204, 401, 403]
    attr_accessor :errors, :response, :success, :config, :over_limit, :suspended

    def initialize(config)
      @config, @errors, @success, @over_limit, @suspended = config, [], false, false, false
    end

    def get(path, params = {})
      request 'get', "#{path}?#{RestClient::Payload.generate(build_params(params))}"
    end

    def post(path, params = {})
      request 'post', path, build_params(params)
    end

    def build_params(params = {})
      params.merge(auth_token: @config.api_key, format: 'json')
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

        if HANDLED_CODES.include?(code)
          send "handle_#{code}", body, code, path, params
        else
          errors << RequestError.new(body, code, path, params)
        end

        Response.new(self, code, path, params)
      end
    end

    def handle_200(body, _code, _path, _params)
      # Check valid JSON body.
      # API returns 'OK' in some cases where response has no
      # meaningful body, which is invalid JSON, so let it be
      # a successfull call
      JSON.parse body unless body == 'OK'
      self.success = true
    rescue JSON::ParserError
      self.response = body
    end

    def handle_204(_body, code, path, params)
      errors << RequestError.new('No Content', code, path, params)
    end

    def handle_401(_body, code, path, params)
      errors << RequestError.new('Invalid Auth Token Provided', code, path, params)
    end

    def handle_403(body, code, path, params)
      if body.match(/Account Suspended/i)
        self.suspended = true
        errors << RequestError.new('Account Suspended', code, path, params)
      elsif body.match(/Request Limit Exceeded/i)
        self.over_limit = true
        errors << RequestError.new('Request Limit Exceeded', code, path, params)
      end
    end
  end
end
