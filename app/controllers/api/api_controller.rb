class Api::ApiController < ActionController::API
  include Api::ExceptionHandleable

  before_action :set_default_format

  def set_default_format
    request.format = :json
  end

  private

  def pagination_dict(collection)
    return if params[:page].blank?

    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page, # use collection.previous_page when using will_paginate
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end
end
