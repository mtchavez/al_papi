module AlPapi
  class RequestError
    attr_reader :message, :code, :path, :params

    def initialize(message, code, path, params) # @private
      @message, @code, @path, @params = message, code, path, params
    end
  end
end
