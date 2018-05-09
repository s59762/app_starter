# 提供基本上每個 modles 都會用到的 Scope
#
module WhitelistAssignable
  extend ActiveSupport::Concern

  class_methods do
    def allowed_filters
      @allowed_filters ||= []
    end

    def allowed_sort_fields
      @allowed_sort_fields ||= []
    end

    def allow_filters(*filters)
      filters.map { |filter| allowed_filters << filter }

      allowed_filters
    end

    def allow_sort_fields(*fields)
      fields.map { |field| allowed_sort_fields << field }

      allowed_sort_fields
    end
  end
end
