require 'rails_helper'

RSpec.describe FetchingDataService, type: :service do
  context '如果 `options[:check_paginate]` 為真，而 params 中不包含 paginate options 時' do
    it '應該要 raise exception' do
      params = {}
      expect { FetchingDataService.new(Admin, params, {check_paginate: true}) }.to raise_error ParametersFailureException
    end
  end

  context '假設有五個 Admin 在 DB 中' do
    let!(:admin_1) { create(:admin, email: 'test1@special.com', password: 'qwerasdf') }
    let!(:admin_2) { create(:admin, email: 'test2@test.com', password: 'qwerasdf') }
    let!(:admin_3) { create(:admin, email: 'test3@special.com', password: 'qwerasdf') }
    let!(:admin_4) { create(:admin, email: 'test4@test.com', password: 'qwerasdf', is_suspended: true) }
    let!(:admin_5) { create(:admin, email: 'test5@special.com', password: 'qwerasdf', is_suspended: true) }

    context '若分頁指定每頁 1 筆資料' do
      let(:params) {
        {
          page: {
            number: 1,
            size: 1
          }
        }
      }
      subject(:result) { FetchingDataService.new(Admin, params).call }

      it '應該只會拿到 1 個 Admin' do
        expect(result.length).to eq 1
      end
    end

    context '若指定以 id DESC 排序' do
      let(:params) {
        {
          sort: '-id'
        }
      }
      subject(:result) { FetchingDataService.new(Admin, params).call }

      it '結果的第一筆應該是 admin_5' do
        expect(result.first).to eq admin_5
      end
    end

    context '若指定 filter 為 suspended，以 id DESC 排序' do
      let(:params) {
        {
          filter: 'suspended',
          sort: '-id'
        }
      }
      subject(:result) { FetchingDataService.new(Admin, params).call }

      it '結果應該僅包含 suspended 的 admins' do
        expect(result.length).to eq 2
      end

      it '結果的第一筆應該是 admin_5' do
        expect(result.first).to eq admin_5
      end
    end

    context '若指定以 email_cont 搜尋 "special"，以 id DESC 排序，每頁 2 筆資料' do
      let(:params) {
        {
          q: {
            email_cont: 'special'
          },
          sort: '-id',
          page: {
            number: '1',
            size: '2'
          }
        }
      }
      subject(:result) { FetchingDataService.new(Admin, params).call }

      it '結果應該僅有 2 筆資料' do
        expect(result.length).to eq 2
      end

      it '結果的最後一筆應該是 admin_3' do
        expect(result.last).to eq admin_3
      end
    end
  end
end
