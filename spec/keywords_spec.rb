require 'spec_helper'

describe AlPapi::Keyword do

  let(:params) { { keyword: 'splash town' } }

  describe 'post' do

    context 'sucessful', vcr: { cassette_name: 'keyword/post/successful' } do

      before do
        @res = AlPapi::Keyword.post params
      end

      it 'returns response results' do
        expect(@res).to be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to_not be_nil
        expect(@res.code).to eql(200)
        expect(@res.params).to eql({ :keyword => 'splash town', :auth_token => TEST_KEY, :format => 'json'})
        expect(@res.path).to eql('/keywords')
      end

      it 'returns body with status of OK' do
        body_hash = @res.parsed_body
        expect(body_hash.status).to eql('OK')
        expect(body_hash.post_count).to eql 1
        expect(body_hash.google_time).to eql 3
      end

    end

  end

  describe 'priority post' do

    context 'successful', vcr: { cassette_name: 'keyword/priority_post/successful' } do

      before do
        @res = AlPapi::Keyword.priority_post params
      end

      it 'returns response results' do
        expect(@res).to be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to_not be_nil
        expect(@res.code).to eql 200
        expect(@res.params).to eql({ :keyword => 'splash town', :auth_token => TEST_KEY, :format => 'json'})
        expect(@res.path).to eql '/keywords/priority'
      end

      it 'returns body with status of OK' do
        body_hash = @res.parsed_body
        expect(body_hash.status).to eql 'OK'
        expect(body_hash.post_count).to eql 1
      end

    end

  end

  describe 'get' do

    context 'context', vcr: { cassette_name: 'keyword/get/successful' } do

      before do
        @res = AlPapi::Keyword.get params
      end

      it 'returns response results' do
        expect(@res).to be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to_not be_nil
        expect(@res.code).to eql 200
      end

      it 'has serp results in body' do
        serp_results = @res.parsed_body
        expect(serp_results.rank_date).to eql '2012-10-15'
        expect(serp_results.serp.length).to eql 121
      end

    end

    context 'failed', vcr: { cassette_name: 'keyword/get/failed' } do

      before do
        @res = AlPapi::Keyword.get params
      end

      it 'returns response results' do
        expect(@res).to_not be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to be_nil
        expect(@res.code).to eql 204
        expect(@res.path).to match '/keywords/get'
      end

    end

  end

end
