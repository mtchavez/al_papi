require 'spec_helper'

describe AlPapi do

  context 'configuration' do

    it 'takes block to set config' do
      AlPapi.configure do |config|
        config.api_key = 'test-key'
      end
      AlPapi.config.api_key.should eql 'test-key'
    end

    it 'can be accessed after being set' do
      AlPapi.configure do |config|
        config.api_key = 'test-key'
      end
      AlPapi.config.api_key.should eql 'test-key'
      AlPapi.config.api_key = 'new-key'
      AlPapi.config.api_key.should eql 'new-key'
    end

  end

end
