require 'test_helper'

class LocalesTest < Test::Unit::TestCase

  def test_successfully_get_supported_locales
    response = get_supported_locales
    assert(response.success?)
    assert(!response.over_limit?)
    assert(!response.suspended?)
    locales = response.parsed_body.locales
    assert_equal('United States - English', locales['en-us'].description)
    assert_equal('http://www.google.com', locales['en-us'].tld)
    assert_equal(233, locales.length)
  end

  def test_attempt_get_supported_locale_with_invalid_engine
    response = get_supported_locales_with_invalid_engine
    assert(!response.parsed_body.supported?)
    assert_equal('stratos is not supported.', response.parsed_body.engine)
  end

  def test_successfully_get_locale_description
    response = get_locale_description
    assert(response.success?)
    assert(!response.over_limit?)
    assert(!response.suspended?)
    assert_equal({
        'engine' => 'google',
        'locale' => 'ko-kr',
        'description' => 'Korea - Korean',
        'supported' => true },
      response.parsed_body)
  end

  def test_get_locale_description_with_invalid_locale
    response = get_locale_description_with_invalid_locale
    assert_equal({
        'engine' => 'google',
        'locale' => 'ko-kr-jp',
        'description' => 'ko-kr-jp is not supported',
        'supported' => false },
      response.parsed_body)
  end

  private

    def get_supported_locales
      VCR.use_cassette('locales/supported/successful') do
        return AlPapi::Locales.supported
      end
    end

    def get_supported_locales_with_invalid_engine
      VCR.use_cassette('locales/supported/bad') do
        return AlPapi::Locales.supported('stratos')
      end
    end

    def get_locale_description
      VCR.use_cassette('locales/description/successful') do
        return AlPapi::Locales.description('google', 'ko-kr')
      end
    end

    def get_locale_description_with_invalid_locale
      VCR.use_cassette('locales/description/bad') do
        return AlPapi::Locales.description('google', 'ko-kr-jp')
      end
    end

end
