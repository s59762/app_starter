# 提供 WebApi 使用分頁與排序的功能

module Api
  module PaginateAndFilterAndSortable
    PAGE_SIZE_LIMIT = 100

    private

    # 擷取 client 端提供的 paginate options，若沒有提供則回傳空 hash 來避免 page_number, page_size 方法的錯誤
    #
    # @return [Hash]
    def page_options
      @page_options_for_pagination ||= params[:page] || {}
    end

    # 當前頁碼
    #
    # @return [String]
    def page_number
      page_options[:number]
    end

    # 每頁 items 數量
    #
    # @return [String]
    def page_size
      page_options[:size]
    end

    # 要求 client 端必須提供 paginate options
    #
    # @raise [ParametersFailureException] 若沒有提供 page_options 時 raise exception
    #
    # @return [Boolean]
    def require_paginate_options!
      raise ParametersFailureException, 'Must provide paginate options with query string like `?page[number]=1&page[size]=20`' unless page_options.present?
    end

    # 驗證 page size option 的值是否合於規範
    #
    # @raise [ParametersFailureException] 若 page size option 大於 PAGE_SIZE_LIMIT 時 raise exception
    #
    # @return [Boolean]
    def validate_page_size!
      return unless page_size

      raise ParametersFailureException, %(page size option is too large. must less than `#{PAGE_SIZE_LIMIT}`) if page_size.to_i > PAGE_SIZE_LIMIT
    end

    # 根據 URL query string 中的 paginate 和 sort options 來查詢 Model 的資料
    #
    # @param [Class] ActiveRecord::Relation 或要查詢的 Model
    #
    # @return [Object] ActiveRecord::Relation 物件
    def query_with_paginate_and_sort_options_for(collection)
      return collection.page(page_number).per(page_size) unless params[:sort].present?

      collection.page(page_number).per(page_size).order(order_options_to_sql)
    end

    # 根據 URL query string 中的 paginate、sort 和 filter options 來查詢 Model 的資料
    #
    # @param [Class] ActiveRecord::Relation 或要查詢的 Model
    #
    # @return [Object] ActiveRecord::Relation 物件
    def query_with_paginate_and_sort_and_filter_options_for(collection)
      return query_with_paginate_and_sort_options_for(collection) unless params[:filter].present?

      query_with_paginate_and_sort_options_for(collection).send(params[:filter])
    end

    # 根據 query string 中的 sort params 來產生正確的 order sql 敘述。
    # JSONAPI 規範中 `sort` 的內容應該為 `sort=attribute_name`，預設為 ASC，若需要 DESC 排序則應表示為 `sort=-attribute_name`
    #
    # @return [String] order sql statement
    # TODO: 每個 Model 本身應該要定義哪些 attributes 可以被用來排序，若給的 attribute 不符規範應該要 raise exception 比較安全。這邊可能會有 SQL Injection 風險。
    def order_options_to_sql
      if params[:sort][0] == '-'
        "#{params[:sort][1..-1]} DESC"
      else
        "#{params[:sort][0..-1]} ASC"
      end
    end

    # 產生分頁資訊
    #
    # @return [Hash]
    def pagination_dict(collection)
      {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.prev_page, # use collection.previous_page when using will_paginate
        total_pages: collection.total_pages,
        total_count: collection.total_count
      }
    end
  end
end
