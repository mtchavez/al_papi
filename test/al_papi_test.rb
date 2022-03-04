require 'test_helper'

class AlPapiTest < Test::Unit::TestCase

  def test_configure_via_block
    AlPapi.configure do |config|
      config.api_key = 'test-key'
    end
    assert_equal('test-key', AlPapi.config.api_key)
  end

  def test_configure_via_setter
    AlPapi.config.api_key = 'new-key'
    assert_equal('new-key', AlPapi.config.api_key)
  end

end
