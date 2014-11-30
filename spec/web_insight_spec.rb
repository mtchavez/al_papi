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
        expect(@res).to be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to_not be_nil
        expect(@res.code).to eql 200
      end

      it 'returns body with status of OK' do
        expect(@res.body).to eql 'OK'
      end

    end

  end

  describe 'get' do

    context 'successful', vcr: { cassette_name: 'web_insight/get/successful' } do

      before do
        @res = AlPapi::WebInsight.get get_params
      end

      it 'returns response results' do
        expect(@res).to be_success
        expect(@res).to_not be_over_limit
        expect(@res).to_not be_suspended
        expect(@res.body).to_not be_nil
        expect(@res.code).to eql 200
      end

      it 'has scrape results in body as JSON' do
        results = @res.parsed_body
        expect(results.url).to eql get_params[:url]
        expect(results.date_created).to eql '2012-10-15'
        expect(results.time_created).to eql '04:01'
        expect(results.redirects.length).to eql 2
        expect(results.results.head_data).to_not be_empty

        page_data = results.results.page_data
        expect(page_data.links.length).to eql 79
        expect(page_data.image_tags.length).to eql 4
        expect(page_data.strong_tags.length).to eql 7
        expect(page_data.body).to_not be_empty
        expect(page_data.h2_tags.length).to eql 10
        expect(page_data.h3_tags.length).to eql 4
        expect(page_data.h4_tags.length).to eql 1
        expect(page_data.b_tags.length).to eql 0
      end

    end

  end

end
