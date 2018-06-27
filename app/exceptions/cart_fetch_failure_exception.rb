# API 中 query string params 有誤時使用的 Exception
class CartFetchFailureException < ApplicationException
  def initialize(description)
    @status = :failed_dependency
    @code = :cart_fetch_failure
    @message = 'Can not find cart'
    @description = description
  end
end
