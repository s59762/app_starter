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
