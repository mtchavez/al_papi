require 'test_helper'

class ConfigTest < Test::Unit::TestCase

  def test_default_host
    assert_equal(AlPapi::Config::DEFAULT_HOST, AlPapi::Config.new.host)
  end

  def test_default_port
    assert_equal(80, AlPapi::Config.new.port)
  end

end
