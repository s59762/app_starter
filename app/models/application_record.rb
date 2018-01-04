# @abstract
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include BasicScopes

  # 回傳 table 最後更新時間
  def self.latest_updated_at
    order(updated_at: :asc).last.updated_at.to_i if exists?
  end
end
