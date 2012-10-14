require 'spec_helper'

describe AlPapi::Request do

  describe 'initialize' do

    it 'takes a config object' do
      config = AlPapi::Config.new(api_key: TEST_KEY)
      req    = AlPapi::Request.new(config)
      req.config.should be_an_instance_of(AlPapi::Config)
    end

    it 'takes a config hash' do
      req = AlPapi::Request.new(api_key: TEST_KEY)
      req.config.should be_an_instance_of(AlPapi::Config)
    end

  end

end
