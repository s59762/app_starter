# 提供根據 params 的選項，從 DB 中提取特定資料的功能

class FetchingDataService
  attr_reader :resource,
              :model,
              :query_options,
              :options

  PAGE_SIZE_LIMIT = 100

  def initialize(resource, params, options = {})
    @resource = resource
    @model = resource.name.constantize
    @query_options = JsonApiParametersNormalizeService.new(model, params)
    @options = options
    @result = resource.ransack(query_options.search).result

    check_for_paginate_params_requirement! if options[:check_paginate]
    validate_page_size!
  end

  # init 時須提供要 query data 的對象，以及 client 端提供的 params
  #
  # @param [Object] resource 可以是 Model 的 class，或是 ActiveRecord::Relation 物件
  # @param [Hash] params client 端提供的 params
  # @param [Hash] options 提供可自訂的選項。`check_paginate` 可設定是否要求 client 端必須提供 paginate params。
  #
  # @raise [ParametersFailureException] 若 `options[:check_paginate]` 為真，params 中不包含 paginate_params 時 raise exception
  def self.call(resource, params, options = {})
    new(resource, params, options).call
  end

  def call
    try_query_with_paginate(@result)
    try_query_with_filter(@result)
    try_query_with_sort(@result)

    @result
  end

  private

  def try_query_with_paginate(collection)
    return false unless query_options.has_paginate?

    @result = collection.page(query_options.page_number).per(query_options.page_size)

    true
  end

  def try_query_with_filter(collection)
    return false unless query_options.has_filter?

    @result = collection.send(query_options.filter)

    true
  end

  def try_query_with_sort(collection)
    return false unless query_options.has_sort?

    @result = collection.order(query_options.sort_sql).includes(query_options.association_name)

    true
  end

  # 驗證 client 端提供的 params 中是否包含 paginate_params
  #
  # @raise [ParametersFailureException] 若 page size option 大於 PAGE_SIZE_LIMIT 時 raise exception
  def check_for_paginate_params_requirement!
    raise ParametersFailureException, 'Must provide paginate options with query string like `?page[number]=1&page[size]=20`' unless query_options.has_paginate?
  end

  # 驗證 page size option 的值是否合於規範
  #
  # @raise [ParametersFailureException] 若 page size option 大於 PAGE_SIZE_LIMIT 時 raise exception
  def validate_page_size!
    return unless query_options.page_size

    raise ParametersFailureException, %(page size option is too large. must less than `#{PAGE_SIZE_LIMIT}`) if query_options.page_size.to_i > PAGE_SIZE_LIMIT
  end
end
