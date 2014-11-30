require 'spec_helper'

describe AlPapi::Config do

  let(:config) { AlPapi::Config.new }

  describe 'initialize' do

    it 'sets default host' do
      expect(config.host).to eql(AlPapi::Config::DEFAULT_HOST)
    end

    it 'sets default port' do
      expect(config.port).to eql(80)
    end

  end

end
