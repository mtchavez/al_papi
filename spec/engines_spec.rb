require 'spec_helper'

describe AlPapi::Engines do

  it 'returns all supported engines' do
    AlPapi::Engines.all.should eql %w[google bing yahoo]
  end

end
