# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
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
#  avatar                 :string
#  name                   :string
#  role                   :integer          default("content_manager")
#  is_suspended           :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#issue_jwt' do
    let!(:admin) { create(:admin) }
    let!(:expected_jwt_payload) do
      {
        sub: admin.id,
        type: 'Admin',
        role: admin.role,
        ref: 'web'
      }
    end
    subject(:issued_jwt_payload) { JsonWebToken.decode(admin.issue_jwt).with_indifferent_access }

    it '要能發行供 web frontend client 使用的 JWT' do
      expect(subject[:sub]).to eq expected_jwt_payload[:sub]
      expect(subject[:type]).to eq expected_jwt_payload[:type]
      expect(subject[:role]).to eq expected_jwt_payload[:role]
      expect(subject[:ref]).to eq expected_jwt_payload[:ref]
    end
  end
end
