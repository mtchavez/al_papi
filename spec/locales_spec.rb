require 'spec_helper'

describe AlPapi::Locales do

  describe 'supported' do

    context 'for engine', vcr: { cassette_name: 'locales/supported/successful' } do

      before do
        @res = AlPapi::Locales.supported
      end

      it 'returns response results' do
        @res.success?.should eql(true)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should_not be_nil
        @res.code.should eql 200
      end

      it 'returns all locales' do
        locales = @res.parsed_body.locales
        locales.length.should eql 233
        locales['en-us'].description.should eql 'United States - English'
        locales['en-us'].tld.should eql 'http://www.google.com'
      end

    end

    context 'for bad engine', vcr: { cassette_name: 'locales/supported/bad' } do

      before do
        @res = AlPapi::Locales.supported 'stratos'
      end

      it 'returns response results' do
        @res.success?.should eql(true)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should_not be_nil
        @res.code.should eql 200
      end

      it 'returns not supported description' do
        @res.parsed_body.engine.should eql 'stratos is not supported.'
        @res.parsed_body.supported.should eql(false)
      end

    end

  end

  describe 'description' do

    describe 'for engine-locale', vcr: { cassette_name: 'locales/description/successful' } do

      before do
        @res = AlPapi::Locales.description 'google', 'ko-kr'
      end

      it 'returns response results' do
        @res.success?.should eql(true)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should_not be_nil
        @res.code.should eql 200
      end

      it 'returns locale description' do
        locale = @res.parsed_body
        locale.engine.should eql 'google'
        locale.locale.should eql 'ko-kr'
        locale.description.should eql 'Korea - Korean'
        locale.supported.should eql(true)
      end

    end

    describe 'for bad engine-locale', vcr: { cassette_name: 'locales/description/bad' } do

      before do
        @res = AlPapi::Locales.description 'google', 'ko-kr-jp'
      end

      it 'returns response results' do
        @res.success?.should eql(true)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should_not be_nil
        @res.code.should eql 200
      end

      it 'returns not supported description' do
        locale = @res.parsed_body
        locale.engine.should eql 'google'
        locale.locale.should eql 'ko-kr-jp'
        locale.description.should eql 'ko-kr-jp is not supported'
        locale.supported.should eql(false)
      end

    end

  end

end
