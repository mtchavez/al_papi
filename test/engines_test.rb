require 'test_helper'

class EnginesTest < Test::Unit::TestCase

  def test_returns_all_supported_engines
    assert_equal(%w[google bing yahoo], AlPapi::Engines.all)
  end

end
