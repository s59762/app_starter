# 提供 WebApi 使用分頁的功能

module Api
  module Paginatable
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
    # @return [Boolean]
    def require_paginate_options!
      raise ParametersFailureException, 'Must provide paginate options with query string like `?page[number]=1&page[size]=20`' unless page_options.present?
    end

    def validate_page_size!
      return unless page_size

      raise ParametersFailureException, %(page size option is too large. must less than `#{PAGE_SIZE_LIMIT}`) unless page_size.to_i < PAGE_SIZE_LIMIT
    end

    # 產生分頁資訊給 Serializer
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
