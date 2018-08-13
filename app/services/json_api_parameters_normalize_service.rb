class JsonApiParametersNormalizeService
  attr_reader :model,
              :paginate,
              :filter,
              :sort,
              :search

  def initialize(model, params)
    @model = model
    @paginate = params[:page] || {}
    @filter = params[:filter]&.to_sym || {}
    @sort = params[:sort] || {}
    @search = params[:q] || {}
  end

  def has_paginate?
    paginate.present?
  end

  def has_filter?
    filter.present? && valid_filter?
  end

  def has_sort?
    sort.present? && valid_sort?
  end

  # 當前頁碼
  #
  # @return [String]
  def page_number
    paginate[:number]
  end

  # 每頁 items 數量
  #
  # @return [String]
  def page_size
    paginate[:size]
  end

  # 根據 sort_option 來產生正確的 order sql 敘述。
  # JSONAPI 規範中 `sort` 的內容應該為 `sort=attribute_name`，預設為 ASC，若需要 DESC 排序則應表示為 `sort=-attribute_name`
  # 若需要依關聯 model 的 attribute 來排序時，應標示關聯的名稱
  #
  # @example Product 以自己的 created_at 排序
  #   sort=-created_at
  #
  # @example Product 以 Product::Variant 的 sales_count 排序（`has_namy :variants`）
  #   sort="variants.sales_count"
  #
  # @return [String] order sql statement
  def sort_sql
    %(#{sort_table_name}.#{sort_column_name} #{sort[0] == '-' ? 'DESC' : 'ASC'})
  end

  # 找出排序的關聯名稱
  def association_name
    @association_name ||= sort_options_array.length > 1 ? sort_options_array.first.to_sym : nil
  end

  private

  # Modle 允許的 filter 白名單
  def filterable_fields
    model.allowed_filters
  end

  # Modle 允許的 sort 白名單
  def sortable_fields
    model.allowed_sort_fields
  end

  def valid_filter?
    filterable_fields.include?(filter)
  end

  def valid_sort?
    sortable_fields.include?(sort.gsub('-', '').to_sym)
  end

  def sort_options_array
    @sort_options_array ||= sort.gsub('-', '').split('.')
  end

  # 找出 Modle 的所有關聯設定，以及對應的 table names
  def associations_table_name_map
    @associations_table_name_map ||= model.reflect_on_all_associations.map { |association| [association.name, model.reflections[association.name.to_s].table_name.to_sym] }.to_h
  end

  # 找出排序關聯的 DB table name
  def sort_table_name
    @sort_table_name ||= associations_table_name_map[association_name] || model.table_name
  end

  # 要排序的 attribute
  def sort_column_name
    @sort_column_name ||= sort_options_array.length > 1 ? sort_options_array.last.to_sym : sort_options_array.first.to_sym
  end
end
