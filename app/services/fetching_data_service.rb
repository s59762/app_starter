# 提供根據 params 的選項，從 DB 中提取特定資料的功能

class FetchingDataService
  attr_reader :resource, :model, :paginate_options, :filter_options, :sort_options, :search_options, :options

  PAGE_SIZE_LIMIT = 100.freeze

  # init 時須提供要 query data 的對象，以及 client 端提供的 params
  #
  # @param [Object] resource 可以是 Model 的 class，或是 ActiveRecord::Relation 物件
  # @param [Hash] params client 端提供的 params
  # @param [Hash] options 提供可自訂的選項。`check_paginate` 可設定是否要求 client 端必須提供 paginate params。
  #
  # @raise [ParametersFailureException] 若 `options[:check_paginate]` 為真，params 中不包含 paginate_params 時 raise exception
  def initialize(resource, params, options = {})
    @resource = resource
    @model = resource.name.constantize
    @paginate_options = params[:page] || {}
    @filter_options = params[:filter] || {}
    @sort_options = params[:sort] || {}
    @search_options = params[:q] || {}
    @options = options
    @result = resource.ransack(search_options).result

    check_for_paginate_options_requirement! if options[:check_paginate]
    validate_page_size!
  end

  def call
    try_query_with_paginate(@result)
    try_query_with_filter(@result)
    try_query_with_sort(@result)

    @result
  end

  private

  def try_query_with_paginate(collection)
    return false if paginate_options.blank?

    @result = collection.page(page_number).per(page_size)

    true
  end

  def try_query_with_filter(collection)
    return false if filter_options.blank?
    return false if invalid_filter?

    @result = collection.send(filter_options)

    true
  end

  def try_query_with_sort(collection)
    return false if sort_options.blank?
    return false if invalid_sort?

    @result = collection.order(sort_options_to_sql)

    true
  end

  # 當前頁碼
  #
  # @return [String]
  def page_number
    paginate_options[:number]
  end

  # 每頁 items 數量
  #
  # @return [String]
  def page_size
    paginate_options[:size]
  end

  # 驗證 client 端提供的 params 中是否包含 paginate_options
  #
  # @raise [ParametersFailureException] 若 page size option 大於 PAGE_SIZE_LIMIT 時 raise exception
  def check_for_paginate_options_requirement!
    raise ParametersFailureException, 'Must provide paginate options with query string like `?page[number]=1&page[size]=20`' if paginate_options.blank?
  end

  # 驗證 page size option 的值是否合於規範
  #
  # @raise [ParametersFailureException] 若 page size option 大於 PAGE_SIZE_LIMIT 時 raise exception
  def validate_page_size!
    return unless page_size

    raise ParametersFailureException, %(page size option is too large. must less than `#{PAGE_SIZE_LIMIT}`) if page_size.to_i > PAGE_SIZE_LIMIT
  end

  # 根據 sort_option 來產生正確的 order sql 敘述。
  # JSONAPI 規範中 `sort` 的內容應該為 `sort=attribute_name`，預設為 ASC，若需要 DESC 排序則應表示為 `sort=-attribute_name`
  #
  # @return [String] order sql statement
  def sort_options_to_sql
    %(#{sort_field} #{sort_direction})
  end

  def sort_field
    @sort_field ||= sort_options[0] == '-' ? sort_options[1..-1] : sort_options[0..-1]
  end

  def sort_direction
    @sort_direction ||= sort_options[0] == '-' ? 'DESC' : 'ASC'
  end

  def filterable_fields
    model::FILTERABLE_FIELDS
  end

  def sortable_fields
    model::SORTABLE_FIELDS
  end

  def invalid_filter?
    !filterable_fields.include?(filter_options)
  end

  def invalid_sort?
    !sortable_fields.include?(sort_field)
  end
end
