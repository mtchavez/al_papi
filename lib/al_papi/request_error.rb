module AlPapi

  class RequestError

    attr_reader :message, :code, :path, :params
    
    def initialize(_message, _code, _path, _params)
      @message, @code, @path, @params = _message, _code, _path, _params
    end

  end

end
