require 'spec_helper'

describe AlPapi::Keyword do

  let(:params) { { keyword: 'splash town' } }

  describe 'post' do

    context 'sucessful' do

      use_vcr_cassette 'keyword/post/successful', :record => :none

      before do
        @res = AlPapi::Keyword.post params
      end

      it 'returns response results' do
        @res.success?.should be_true
        @res.over_limit?.should be_false
        @res.suspended?.should be_false
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

    context 'successful' do

      use_vcr_cassette 'keyword/priority_post/successful', :record => :none

      before do
        @res = AlPapi::Keyword.priority_post params
      end

      it 'returns response results' do
        @res.success?.should be_true
        @res.over_limit?.should be_false
        @res.suspended?.should be_false
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

    context 'context' do

      use_vcr_cassette 'keyword/get/successful', :record => :none

      before do
        @res = AlPapi::Keyword.get params
      end

      it 'returns response results' do
        @res.success?.should be_true
        @res.over_limit?.should be_false
        @res.suspended?.should be_false
        @res.body.should_not be_nil
        @res.code.should eql 200
      end

      it 'has serp results in body' do
        serp_results = @res.parsed_body
        serp_results.rank_date.should eql '2012-10-15'
        serp_results.serp.length.should eql 121
      end

    end

    context 'failed' do

      use_vcr_cassette 'keyword/get/failed', :record => :none

      before do
        @res = AlPapi::Keyword.get params
      end

      it 'returns response results' do
        @res.success?.should be_false
        @res.over_limit?.should be_false
        @res.suspended?.should be_false
        @res.body.should be_nil
        @res.code.should eql 204
        @res.path.should match '/keywords/get'
      end

    end

  end

end
