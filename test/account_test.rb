require 'test_helper'

class AccountTest < Test::Unit::TestCase

  def test_successful_response
    assert(get_account_settings.success?)
  end

  def test_returns_account_info
    account = get_account_settings.parsed_body
    assert(!account.user.nil?)
    assert_equal(account.user.current_post_count, 2)
    assert_equal(account.user.hourly_post_limit, 160_000)
    assert_equal(account.user.current_get_count, 5_822)
    assert_equal(account.user.hourly_get_limit, 300_000)
    assert_equal(account.user.current_balance, -60_471.16)
  end
  
  def test_returns_system_messages
    account = get_account_settings.parsed_body
    assert(!account.messages.nil?)
    assert(account.messages.system.empty?)
  end

  def test_returns_queue_times
    account = get_account_settings.parsed_body
    assert_equal(account.queue.yahoo_time, 2)
    assert_equal(account.queue.bing_time, 15)
    assert_equal(account.queue.google_time, 3)
  end

  private

    def get_account_settings(vcr_file: 'account/settings', account_id: '79')
      VCR.use_cassette(vcr_file) do
        return AlPapi::Account.info(account_id)
      end
    end

end
