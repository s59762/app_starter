# 提供基本上每個 modles 都會用到的 Scope
#
# @example recent
#   ExampleModel.recent # => 以建立時間排序新的在前
# @example by_date(date)
#   ExampleModel.by_date(3.days.ago) # => 以日期查詢
# @example unselect(*columns)
#   ExampleModel.unselect(:created_at, :updated_at)
#   # `.unselect` 是類似 `.select` 的方法，可以在查詢時排除不需要的欄位
module BasicScopes
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.instance_eval do
      scope :recent, -> { order(created_at: :desc) }
      scope :by_date, ->(date) { where(created_at: date.beginning_of_day..date.end_of_day) }
      scope :unselect, ->(*columns) {
        removed_columns = columns.map(&:to_s)
        select(column_names - removed_columns)
      }
    end
  end
end
