require 'spec_helper'

describe AlPapi::Keyword do

  let(:params) { { keyword: 'splash town' } }

  describe 'post' do

    context 'sucessful', vcr: { cassette_name: 'keyword/post/successful' } do

      before do
        @res = AlPapi::Keyword.post params
      end

      it 'returns response results' do
        @res.success?.should eql(true)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should_not be_nil
        @res.code.should eql 200
        @res.params.should eql({ :keyword => 'splash town', :auth_token => TEST_KEY, :format => 'json'})
        @res.path.should eql '/keywords'
      end

      it 'returns body with status of OK' do
        body_hash = @res.parsed_body
        body_hash.status.should eql 'OK'
        body_hash.post_count.should eql 1
        body_hash.google_time.should eql 3
      end

    end

  end

  describe 'priority post' do

    context 'successful', vcr: { cassette_name: 'keyword/priority_post/successful' } do

      before do
        @res = AlPapi::Keyword.priority_post params
      end

      it 'returns response results' do
        @res.success?.should eql(true)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should_not be_nil
        @res.code.should eql 200
        @res.params.should eql({ :keyword => 'splash town', :auth_token => TEST_KEY, :format => 'json'})
        @res.path.should eql '/keywords/priority'
      end

      it 'returns body with status of OK' do
        body_hash = @res.parsed_body
        body_hash.status.should eql 'OK'
        body_hash.post_count.should eql 1
      end

    end

  end

  describe 'get' do

    context 'context', vcr: { cassette_name: 'keyword/get/successful' } do

      before do
        @res = AlPapi::Keyword.get params
      end

      it 'returns response results' do
        @res.success?.should eql(true)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should_not be_nil
        @res.code.should eql 200
      end

      it 'has serp results in body' do
        serp_results = @res.parsed_body
        serp_results.rank_date.should eql '2012-10-15'
        serp_results.serp.length.should eql 121
      end

    end

    context 'failed', vcr: { cassette_name: 'keyword/get/failed' } do

      before do
        @res = AlPapi::Keyword.get params
      end

      it 'returns response results' do
        @res.success?.should eql(false)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should be_nil
        @res.code.should eql 204
        @res.path.should match '/keywords/get'
      end

    end

  end

end
