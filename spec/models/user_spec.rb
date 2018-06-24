# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#guest?' do
    let!(:user) { create(:user) }

    it '一個註冊使用者，其身份不會是「訪客」' do
      expect(user.guest?).to be_falsey
    end
  end

  describe '#issue_jwt' do
    subject(:issued_jwt_payload) { JsonWebToken.decode(user.issue_jwt).with_indifferent_access }

    let!(:user) { create(:user) }
    let!(:expected_jwt_payload) do
      {
        sub: user.id,
        type: 'User',
        ref: 'web'
      }
    end

    it '要能發行供 web frontend client 使用的 JWT' do
      expect(subject[:sub]).to eq expected_jwt_payload[:sub]
      expect(subject[:type]).to eq expected_jwt_payload[:type]
      expect(subject[:ref]).to eq expected_jwt_payload[:ref]
    end
  end
end
