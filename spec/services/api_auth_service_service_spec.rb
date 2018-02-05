require 'rails_helper'

RSpec.describe ApiAuthServiceService, type: :service do
  let(:admin) { create :admin }
  let(:token) { %(Bearer #{admin.issue_jwt}) }

  describe '#initialize' do
    context '若沒有提供 token' do
      it '必須 raise Exception' do
        expect { ApiAuthServiceService.new('') }.to raise_error AuthenticateFailureException
        expect { ApiAuthServiceService.new(nil) }.to raise_error AuthenticateFailureException
      end
    end

    context '若提供非法的 token' do
      it '必須 raise Exception' do
        expect { ApiAuthServiceService.new(token[0..-2]) }.to raise_error AuthenticateFailureException
      end
    end
  end

  describe '#call' do
    it '必須回傳 Token 所代表的當前使用者' do
      expect(ApiAuthServiceService.new(token).call).to eq admin
    end
  end
end
