require 'test_helper'

class WebInsightTest < Test::Unit::TestCase
  
  def test_post_web_insight
    response = post_web_insight
    assert(response.success?)
    assert(!response.suspended?)
    assert(!response.over_limit?)
    assert_equal('OK', response.body)
  end

  def test_get_web_insight
    response = get_web_insight
    assert(response.success?)
    assert(!response.suspended?)
    assert(!response.over_limit?)
    data = response.parsed_body
    assert_equal('http://authoritylabs.com/blog', data.url)
    assert_equal('2012-10-15', data.date_created)
    assert_equal('04:01', data.time_created)
    assert_equal(2, data.redirects.length)
    assert(!data.results.head_data.empty?)
    page_data = data.results.page_data
    assert_equal(79, page_data.links.length)
    assert_equal(4, page_data.image_tags.length)
    assert_equal(7, page_data.strong_tags.length)
    assert(!page_data.body.empty?)
    assert_equal(10, page_data.h2_tags.length)
    assert_equal(4, page_data.h3_tags.length)
    assert_equal(1, page_data.h4_tags.length)
    assert_equal(0, page_data.b_tags.length)
  end

  private
    
    def post_web_insight
      VCR.use_cassette('web_insight/post/successful') do
        return AlPapi::WebInsight.post url: 'http://authoritylabs.com/blog',
          callback: 'http://my.callback.com/callbacks'
      end
    end

    def get_web_insight
      VCR.use_cassette('web_insight/get/successful') do
        return AlPapi::WebInsight.get url: 'http://authoritylabs.com/blog',
          date_created: '2012-10-15',
          time_created: '04:01'
      end
    end

end
