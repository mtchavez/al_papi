module AlPapi

  class Http # @private

    attr_accessor :errors, :response, :success, :config

    def initialize(_config)
      @config, @errors, @success = _config, [], false
    end

    def get(path, params = {})
      request 'get', "#{path}?#{RestClient::Payload.generate(build_params(params))}"
    end

    def post(path, params = {})
      request 'post', path, build_params(params)
    end
    
    def build_params(params = nil)
      return nil if params.empty?
      return nil unless params.is_a?(Hash)
      params.merge(auth_token: @config.api_key, format: 'json')
    end

    def request(http_verb, path, params = nil)
      url  = "#{@config.host}#{path}"
      args = http_verb == 'post' ? [http_verb, url, params] : [http_verb, url]

      response = RestClient.send *args do |res, req, raw_res|
        body = raw_res.body
        code = raw_res.code.to_i

        self.response = body
        self.errors   = []

        case code
        when 200
          begin 
            parsed = JSON.parse body
          rescue JSON::ParserError => e
            self.response = body
          end
          self.success = true
        when 204
          self.errors << RequestError.new('No Content', code, path, params)
        when 401
          self.errors << RequestError.new('Invalid Auth Token Provided', code, path, params)
        else
          self.errors << RequestError.new(body, code, path, params)
        end

        Response.new(self, code, path, params)
      end
    end

  end

end
