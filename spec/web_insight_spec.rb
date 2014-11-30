require 'spec_helper'

describe AlPapi::WebInsight do

  let(:post_params) { { url: 'http://authoritylabs.com/blog', callback: 'http://my.callback.com/callbacks' } }
  let(:get_params)  { { url: 'http://authoritylabs.com/blog', date_created: '2012-10-15', time_created: '04:01' } }

  describe 'post' do

    context 'successful', vcr: { cassette_name: 'web_insight/post/successful' } do

      before do
        @res = AlPapi::WebInsight.post post_params
      end

      it 'returns response results' do
        @res.success?.should eql(true)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should_not be_nil
        @res.code.should eql 200
      end

      it 'returns body with status of OK' do
        @res.body.should eql 'OK'
      end

    end

  end

  describe 'get' do

    context 'successful', vcr: { cassette_name: 'web_insight/get/successful' } do

      before do
        @res = AlPapi::WebInsight.get get_params
      end

      it 'returns response results' do
        @res.success?.should eql(true)
        @res.over_limit?.should eql(false)
        @res.suspended?.should eql(false)
        @res.body.should_not be_nil
        @res.code.should eql 200
      end

      it 'has scrape results in body as JSON' do
        results = @res.parsed_body
        results.url.should eql get_params[:url]
        results.date_created.should eql '2012-10-15'
        results.time_created.should eql '04:01'
        results.redirects.length.should eql 2
        results.results.head_data.should_not be_empty

        page_data = results.results.page_data
        page_data.links.length.should eql 79
        page_data.image_tags.length.should eql 4
        page_data.strong_tags.length.should eql 7
        page_data.body.should_not be_empty
        page_data.h2_tags.length.should eql 10
        page_data.h3_tags.length.should eql 4
        page_data.h4_tags.length.should eql 1
        page_data.b_tags.length.should eql 0
      end

    end

  end

end
