require 'spec_helper'

describe AlPapi::Account do

  describe 'info' do

    context 'for your account' do

      use_vcr_cassette 'account/settings', :record => :none

      before do
        @res = AlPapi::Account.info '79'
      end

      it 'returns response results' do
        @res.should be_success
      end

      it 'returns account info' do
        account = @res.parsed_body
        account.user.should_not be_nil
        account.user.current_post_count.should eql 2
        account.user.hourly_post_limit.should eql 160000
        account.user.current_get_count.should eql 5822
        account.user.hourly_get_limit.should eql 300000
        account.user.current_balance.should eql -60471.16
      end

      it 'returns system messages' do
        account = @res.parsed_body
        account.messages.should_not be_nil
        account.messages.system.should be_empty
      end

      it 'returns queue times' do
        account = @res.parsed_body
        account.queue.yahoo_time.should eql 2
        account.queue.bing_time.should eql 15
        account.queue.google_time.should eql 3
      end

    end

    context 'bad request' do

      use_vcr_cassette 'account/another_account_settings', :record => :none

      before do
        @res = AlPapi::Account.info '78'
      end

      it 'returns response results' do
        pending('API currently allows you to get another accounts info')
        @res.body.success?.should be_false
      end

    end

  end

end
