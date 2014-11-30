require 'spec_helper'

describe AlPapi::Locales do

  describe 'supported' do

    context 'for engine', vcr: { cassette_name: 'locales/supported/successful' } do

      before do
        @res = AlPapi::Locales.supported
      end

      it 'returns response results' do
        expect(@res).to be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to_not be_nil
        expect(@res.code).to eql 200
      end

      it 'returns all locales' do
        locales = @res.parsed_body.locales
        expect(locales.length).to eql 233
        expect(locales['en-us'].description).to eql 'United States - English'
        expect(locales['en-us'].tld).to eql 'http://www.google.com'
      end

    end

    context 'for bad engine', vcr: { cassette_name: 'locales/supported/bad' } do

      before do
        @res = AlPapi::Locales.supported 'stratos'
      end

      it 'returns response results' do
        expect(@res).to be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to_not be_nil
        expect(@res.code).to eql 200
      end

      it 'returns not supported description' do
        expect(@res.parsed_body.engine).to eql 'stratos is not supported.'
        expect(@res.parsed_body.supported).to eql(false)
      end

    end

  end

  describe 'description' do

    describe 'for engine-locale', vcr: { cassette_name: 'locales/description/successful' } do

      before do
        @res = AlPapi::Locales.description 'google', 'ko-kr'
      end

      it 'returns response results' do
        expect(@res).to be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to_not be_nil
        expect(@res.code).to eql 200
      end

      it 'returns locale description' do
        locale = @res.parsed_body
        expect(locale.engine).to eql 'google'
        expect(locale.locale).to eql 'ko-kr'
        expect(locale.description).to eql 'Korea - Korean'
        expect(locale.supported).to eql(true)
      end

    end

    describe 'for bad engine-locale', vcr: { cassette_name: 'locales/description/bad' } do

      before do
        @res = AlPapi::Locales.description 'google', 'ko-kr-jp'
      end

      it 'returns response results' do
        expect(@res).to be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to_not be_nil
        expect(@res.code).to eql 200
      end

      it 'returns not supported description' do
        locale = @res.parsed_body
        expect(locale.engine).to eql 'google'
        expect(locale.locale).to eql 'ko-kr-jp'
        expect(locale.description).to eql 'ko-kr-jp is not supported'
        expect(locale.supported).to eql(false)
      end

    end

  end

end
