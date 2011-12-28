require File.join( File.dirname(File.expand_path(__FILE__)), 'base')

describe AlPapi::Config do
  let(:config) { AlPapi::Config.new api_key: TEST_KEY }

  describe 'initialize' do

    it 'sets api key' do
      config.api_key.should eql TEST_KEY
    end

    it 'sets default host' do
      config.host.should eql AlPapi::Config::DEFAULT_HOST
    end

    it 'sets default port' do
      config.port.should eql 80
    end

  end

end
