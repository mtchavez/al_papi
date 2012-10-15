require 'spec_helper'

describe AlPapi::Config do

  let(:config) { AlPapi::Config.new }

  describe 'initialize' do

    it 'sets default host' do
      config.host.should eql AlPapi::Config::DEFAULT_HOST
    end

    it 'sets default port' do
      config.port.should eql 80
    end

  end

end
