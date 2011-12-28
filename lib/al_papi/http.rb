module AlPapi

  class Http # :nodoc:all:

    def initialize(req)
      @api_req, @config = req, req.config
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

        @api_req.response = body
        @api_req.errors   = []

        case code
        when 200
          @api_req.response = JSON.parse body
          @api_req.success = true
        when 204
          @api_req.errors << RequestError.new('No Content', code, path, params)
        when 401
          @api_req.errors << RequestError.new('Invalid Auth Token Provided', code, path, params)
        else
          @api_req.errors << RequestError.new(body, code, path, params)
        end

        @api_req
      end
    end

  end

end
