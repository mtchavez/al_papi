require 'spec_helper'

describe AlPapi::Engines do

  it 'returns all supported engines' do
    expect(AlPapi::Engines.all).to eql(%w[google bing yahoo])
  end

end
