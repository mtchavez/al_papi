require 'spec_helper'

describe AlPapi::Account do

  describe 'info' do

    context 'for your account', vcr: { cassette_name: 'account/settings' } do

      before do
        @res = AlPapi::Account.info '79'
      end

      it 'returns response results' do
        expect(@res).to be_success
      end

      it 'returns account info' do
        account = @res.parsed_body
        expect(account.user).to_not be_nil
        expect(account.user.current_post_count).to eql(2)
        expect(account.user.hourly_post_limit).to eql(160000)
        expect(account.user.current_get_count).to eql(5822)
        expect(account.user.hourly_get_limit).to eql(300000)
        expect(account.user.current_balance).to eql(-60471.16)
      end

      it 'returns system messages' do
        account = @res.parsed_body
        expect(account.messages).to_not be_nil
        expect(account.messages.system).to be_empty
      end

      it 'returns queue times' do
        account = @res.parsed_body
        expect(account.queue.yahoo_time).to eql(2)
        expect(account.queue.bing_time).to eql(15)
        expect(account.queue.google_time).to eql(3)
      end

    end

    context 'bad request', vcr: { cassette_name: 'account/another_account_settings' } do

      before do
        @res = AlPapi::Account.info '78'
      end

      it 'returns response results' do
        pending('API currently allows you to get another accounts info')
        expect(@res.body).to_not be_success
      end

    end

  end

end
