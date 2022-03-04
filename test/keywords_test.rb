require 'test_helper'

class KeywordsTest < Test::Unit::TestCase

  def test_successfully_post_keyword
    response = post_keyword
    assert(response.success?)
    assert(!response.over_limit?)
    assert(!response.suspended?)
    assert_equal({keyword: 'splash town', auth_token: TEST_KEY, format: 'json'},
      response.params)
    assert_equal('/keywords', response.path)
    assert_equal({'status' => 'OK', 'post_count' => 1, 'google_time' => 3},
      response.parsed_body)
  end

  def test_successfully_post_priority_keyword
    response = priority_post_keyword
    assert(response.success?)
    assert(!response.over_limit?)
    assert(!response.suspended?)
    assert_equal({keyword: 'splash town', auth_token: TEST_KEY, format: 'json'},
      response.params)
    assert_equal('/keywords/priority', response.path)
    assert_equal({'status' => 'OK', 'post_count' => 1},
      response.parsed_body)
  end

  def test_successfully_get_keyword
    response = get_keyword
    assert(response.success?)
    assert(!response.over_limit?)
    assert(!response.suspended?)
    assert_equal('2012-10-15', response.parsed_body['rank_date'])
    assert_equal(121, response.parsed_body.serp.length)
  end

  def test_fail_get_keyword
    response = get_keyword(cassette: 'keyword/get/failed')
    assert(!response.success?)
    assert(response.body.empty?)
    assert_equal(204, response.code)
    assert_match('/keywords/get', response.path)
  end

  private

    def post_keyword
      VCR.use_cassette('keyword/post/successful') do
        return AlPapi::Keyword.post(keyword: 'splash town')
      end
    end

    def priority_post_keyword
      VCR.use_cassette('keyword/priority_post/successful') do
        return AlPapi::Keyword.priority_post(keyword: 'splash town')
      end
    end

    def get_keyword(cassette: 'keyword/get/successful')
      VCR.use_cassette(cassette) do
        return AlPapi::Keyword.get(keyword: 'splash town')
      end
    end

end
